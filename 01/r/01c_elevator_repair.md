Week 1 lab: Elevator Repair
================

## Goals

  - Build a simple model based on synthetic count data: number of
    elevator failures per year in a building  
  - Run inference in the model, and make decisions using posterior
    predictions

## The plan

  - load synthetic data: number of elevator failures per year for your
    building and three nearby buildings  
  - model data as a Poisson-distributed variable, using a Gamma
    distribution as a prior over the Poisson intensity  
  - use posterior predictions about your model to determine whether the
    four buildings should pool their resources or continue to purchase
    elevator service individually.

<!-- end list -->

``` r
library(tidyverse)
library(praise)
library(rstan)

# set a default ggplot2 theme to all other plots
theme_set(theme_minimal())

# use any cores we have for Stan model
options(mc.cores = parallel::detectCores())

# write stan models to disk so we don't have to recompile every time
rstan_options(auto_write=TRUE)
```

### Load the data

``` r
failures <- read_csv('elevator_failures.csv')
failures
```

    ## # A tibble: 5 x 4
    ##     you friend1 friend2 friend3
    ##   <dbl>   <dbl>   <dbl>   <dbl>
    ## 1     2       6       4       2
    ## 2     2       1       2       3
    ## 3     3       4       2       0
    ## 4     4       4       4       2
    ## 5     4       5       3       3

### Build the model

Let’s assume that the elevator failures happen at a constant probability
per time of happening and are uncorrelated with each other- so they’ll
be described reasonbly well by a homogeneous Poisson process.

The Poisson likelihood has one parameter
(![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda"))
that is equal to both the mean and the standard deviation of the
distribution. ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
"\\lambda") has to be nonnegative but doesn’t have an upper bound, so
we’ll use a Gamma distribution.

Prior:

![\\lambda \\sim
gamma(a,b)](https://latex.codecogs.com/png.latex?%5Clambda%20%5Csim%20gamma%28a%2Cb%29
"\\lambda \\sim gamma(a,b)")

Likelihood:

![y \\sim
Poisson(\\lambda)](https://latex.codecogs.com/png.latex?y%20%5Csim%20Poisson%28%5Clambda%29
"y \\sim Poisson(\\lambda)")

Example samples from a Gamma distribution:

``` r
# generate random samples from a the gamma distribution
a <- 2
b <- 0.5
prior_samples <- tibble(lambda = rgamma(n = 1000, a, b))
prior_samples
```

    ## # A tibble: 1,000 x 1
    ##    lambda
    ##     <dbl>
    ##  1   1.77
    ##  2   5.40
    ##  3   1.42
    ##  4   4.05
    ##  5   2.78
    ##  6   1.54
    ##  7   1.94
    ##  8   1.98
    ##  9   3.04
    ## 10   1.14
    ## # … with 990 more rows

``` r
# plot the prior samples
ggplot(prior_samples) + geom_histogram(aes(x = lambda), bins = 100)
```

![](01c_elevator_repair_files/figure-gfm/plot-prior-1.png)<!-- -->

## Drawing samples from a prior

If we have a likelihood
![P(x|\\theta)](https://latex.codecogs.com/png.latex?P%28x%7C%5Ctheta%29
"P(x|\\theta)") and a prior
![P(\\theta)](https://latex.codecogs.com/png.latex?P%28%5Ctheta%29
"P(\\theta)"), then we can define a prior predictive distribution by
marginalizing ![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta
"\\theta") out,

![P(x) = \\int
P(x|\\theta)P(\\theta)d\\theta](https://latex.codecogs.com/png.latex?P%28x%29%20%3D%20%5Cint%20P%28x%7C%5Ctheta%29P%28%5Ctheta%29d%5Ctheta
"P(x) = \\int P(x|\\theta)P(\\theta)d\\theta")

which we could then use to sample fake data. This won’t be horribly
interesting for such a simple model- but as we get to more complicated
models, it can be a good early-warning system for catching mistakes. If
the prior really does represent our prior knowledge, then sampling data
using it should generate data that seems plausible (but broader than the
distribution of data we know about). If we get data that looks
implausible (for example, violating a law of physics or spread across
many orders of magnitude more than the data) then chances are we’ve
mis-specified our priors. From *Visualization in Bayesian workflow*,

> As with the standard concept of weakly informative priors, it is
> important that this prior predictive distribution for the data has at
> least some mass around extreme but plausible data sets. On the other
> hand, there should be no mass on completely implausible data sets. We
> recommend assessing how informative the prior distribution on the data
> is by generating a “flip book” of simulated datasets that can be used
> to investigate the variability and multivariate structure of the
> distribution

For a simple model like this it’d be easy to use base R to generate
prior predictive values- it’s also possible to use `stan` for this;
let’s walk through the process so we can repeat it when we get to more
interesting models.

We’ll specify prior hyperparameters as our data (which will let us play
with them without recompiling the model each time) and use the
`generated quantities` block to sample parameters and fake data. Note
that no actual inference is happening within this model\!

``` r
prior_model_code <- "
data {
    real alpha; // shape of gamma distribution
    real beta; // rate of gamma distribution
}

model {
}

generated quantities {
    real lambda; // parameter
    int y_sim; // fake data
    
    lambda = gamma_rng(alpha, beta);
    y_sim = poisson_rng(lambda);
}
"

prior_model <- stan_model(model_code = prior_model_code)
```

When we generate prior samples, we need to run `stan` with the keyword
argument `algorithm='Fixed_param'`. Sampling from this model will
generate random samples for
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda")
and ![y\_{sim}](https://latex.codecogs.com/png.latex?y_%7Bsim%7D
"y_{sim}").

``` r
prior_data <- list(alpha = 2, beta = 0.5)
prior_fit <- sampling(prior_model, prior_data, iter = 10000, chains = 1, algorithm = "Fixed_param")
```

    ## 
    ## SAMPLING FOR MODEL 'dac28d06e21367cae72c308e64266d92' NOW (CHAIN 1).
    ## Chain 1: Iteration:    1 / 10000 [  0%]  (Sampling)
    ## Chain 1: Iteration: 1000 / 10000 [ 10%]  (Sampling)
    ## Chain 1: Iteration: 2000 / 10000 [ 20%]  (Sampling)
    ## Chain 1: Iteration: 3000 / 10000 [ 30%]  (Sampling)
    ## Chain 1: Iteration: 4000 / 10000 [ 40%]  (Sampling)
    ## Chain 1: Iteration: 5000 / 10000 [ 50%]  (Sampling)
    ## Chain 1: Iteration: 6000 / 10000 [ 60%]  (Sampling)
    ## Chain 1: Iteration: 7000 / 10000 [ 70%]  (Sampling)
    ## Chain 1: Iteration: 8000 / 10000 [ 80%]  (Sampling)
    ## Chain 1: Iteration: 9000 / 10000 [ 90%]  (Sampling)
    ## Chain 1: Iteration: 10000 / 10000 [100%]  (Sampling)
    ## Chain 1:  Elapsed Time: 0 seconds (Warm-up)
    ## Chain 1:                0.012563 seconds (Sampling)
    ## Chain 1:                0.012563 seconds (Total)

We will now extract the samples from the fit. **rstan** knows how to
convert samples to `data.frame`. We then convert that `data.frame` to a
`tibble` for nicer printing.

``` r
prior_samples <- as.data.frame(prior_fit)
prior_samples <- as_tibble(prior_samples)
prior_samples
```

    ## # A tibble: 5,000 x 3
    ##    lambda y_sim  lp__
    ##     <dbl> <dbl> <dbl>
    ##  1   5.35     6     0
    ##  2   3.62     1     0
    ##  3   4.17     1     0
    ##  4   3.26     7     0
    ##  5   5.51     4     0
    ##  6   1.56     3     0
    ##  7   4.88     6     0
    ##  8   2.19     2     0
    ##  9   2.15     3     0
    ## 10   1.43     0     0
    ## # … with 4,990 more rows

Now let’s plot a histogram of our
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda")
samples. We’ll also overlay the expected density from a gamma
distribution with ![\\alpha
= 2](https://latex.codecogs.com/png.latex?%5Calpha%20%3D%202
"\\alpha = 2") and ![\\beta
= 0.5](https://latex.codecogs.com/png.latex?%5Cbeta%20%3D%200.5
"\\beta = 0.5")

``` r
ggplot(prior_samples, aes(x = lambda)) + 
    geom_histogram(aes(y = ..density..), bins = 100) +
    stat_function(fun = dgamma, args = list(shape = 2, rate = 0.5), color = "red") +
    labs(title = "Random samples match expected probability density",
         subtitle = "Gamma distribution sampled with stan",
         x = expression(lambda),
         y = expression(p(lambda)))
```

![](01c_elevator_repair_files/figure-gfm/plot-prior-samples-1.png)<!-- -->

We also generated fake ![Y](https://latex.codecogs.com/png.latex?Y "Y")
data with our model. These are known as prior-predictive samples. Its a
good idea to check that the data generated from a prior makes sense.

``` r
ggplot(prior_samples, aes(x = y_sim)) + 
    geom_bar(aes(y = ..prop..)) +
    labs(x = "elevator malfunctions per year",
         y = "prior predictive distribution")
```

![](01c_elevator_repair_files/figure-gfm/plot-prior-predictive-1.png)<!-- -->

### Building a full Stan Model

We will build a real life stan model now. There are various sections in
a stan model. Some are optional, but the ones you will most likely
encounter are:

  - **data** Defines all our data inputs and related structures. For our
    elevator model, this is where will pass the counts of elevator
    failures.
  - **parameters** Defines the unknown variables that we want to infer
    from the data. In our case, we want to estimate
    ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
    "\\lambda"), the mean rate of failures.
  - **model** Defines the relationships between data and parameters
    through probability distributions. For this example, we are saying
    elevator failures are generated by a poisson distribution with mean
    ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
    "\\lambda"), while
    ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
    "\\lambda") itself is generated from a gamma distribution with known
    parameters ![\\alpha
    = 2](https://latex.codecogs.com/png.latex?%5Calpha%20%3D%202
    "\\alpha = 2") and ![\\beta
    = 0.5](https://latex.codecogs.com/png.latex?%5Cbeta%20%3D%200.5
    "\\beta = 0.5").
  - **generated quantities** Is optional but usually useful for
    generating new data from our parameter estimates.

<!-- end list -->

``` r
model_code <- "
data {
    // the data block defines the data structures where our data will go
    // N is the number of observations- an integer with a lower-bound of 0
    int<lower=0> N;
    
    // y is an array of the actual observations (integers with value 0 or 1), of length N
    int<lower=0> y[N];
}

parameters {
    // the parameters block defines the variables we're doing inference on- in
    // this case, just lambda, the poisson 'intensity' parameter. 
    
    // for a poisson distribution, this parameter is both the expected mean
    // and the standard deviation
    real<lower=0> lambda;
}

model {
    // the model block ties the room together.
    
    // connect the lambda parameter to a prior distribution,
    lambda ~ gamma(2, 0.5); // specify prior hyperparameters here
    
    // choose a likelihood to connect observations to the lambda parameter
    y ~ poisson(lambda);
}

generated quantities {
    // we can also have stan generate anything else we want- we'll use this a
    // lot for posterior predictive checks. code in this block is evaluated 
    // once per sample.
    
    // so every time stan draws a value of lambda, let's also have it draw
    // a simulated observation from that value
    int y_sim;
    
    // generate posterior predictive samples
    y_sim = poisson_rng(lambda);
}
"
model <- stan_model(model_code = model_code)
```

### Draw samples from the posterior

Run inference on the data from your building. First build a list of data
required by the Stan model (`N` and `y`).

``` r
data <- list(
    N = nrow(failures),
    y = failures$you
)
```

Then use the `sampling()` function to run MCMC and produce samples of
our estimate for `lambda`. We will run for 10,000 iterations on 4
parallel chains.

``` r
fit <- sampling(model, data, iter = 10000, chains = 4)
```

Printing `fit` summarizes the result of the model.

``` r
fit
```

    ## Inference for Stan model: 21616dde0c961fa8faf5b30e3eee6da0.
    ## 4 chains, each with iter=10000; warmup=5000; thin=1; 
    ## post-warmup draws per chain=5000, total post-warmup draws=20000.
    ## 
    ##        mean se_mean   sd  2.5%  25%  50%  75% 97.5% n_eff Rhat
    ## lambda 3.09    0.01 0.75  1.78 2.56 3.03 3.56  4.69  7679    1
    ## y_sim  3.09    0.02 1.90  0.00 2.00 3.00 4.00  7.00 15389    1
    ## lp__   1.68    0.01 0.72 -0.42 1.52 1.96 2.13  2.18  7849    1
    ## 
    ## Samples were drawn using NUTS(diag_e) at Fri Oct  4 00:28:30 2019.
    ## For each parameter, n_eff is a crude measure of effective sample size,
    ## and Rhat is the potential scale reduction factor on split chains (at 
    ## convergence, Rhat=1).

We can extract the samples from this procedure using the
`as.data.frame()` function, as we did previously.

``` r
posterior_samples <- as.data.frame(fit)
posterior_samples <- as_tibble(posterior_samples)
posterior_samples
```

    ## # A tibble: 20,000 x 3
    ##    lambda y_sim  lp__
    ##     <dbl> <dbl> <dbl>
    ##  1   3.44     4  2.08
    ##  2   3.57     6  2.00
    ##  3   3.32     3  2.14
    ##  4   3.68     1  1.91
    ##  5   3.20     7  2.17
    ##  6   2.56     1  1.90
    ##  7   2.93     0  2.16
    ##  8   3.07     3  2.18
    ##  9   2.45     2  1.75
    ## 10   2.39     4  1.67
    ## # … with 19,990 more rows

Note that there are 20,000 samples. Where does this number come from? We
ran four separate `chains`, each with 10,000 iterations. However, we
also specified a `warmup` of 5,000 iterations, which means these samples
are throw away. This leaves us with with a total of 5,000 useful
iterations per chain, which totals 20,000.

Let’s plot a histogram of the the samples we have of the prior and
posterior for ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
"\\lambda").

``` r
# creating a dataframe to nicely use ggplot
prior_post <- bind_rows(posterior = posterior_samples, prior = prior_samples, .id = "type")

# plot a histogram
ggplot(prior_post, aes(x = lambda, fill = type)) +
    geom_histogram(aes(y = ..density..), bins = 100, position = 'identity', alpha = 0.7) +
    labs(title = "Estimates of lambda",
         subtitle = "Comparison of prior and posterior samples")
```

![](01c_elevator_repair_files/figure-gfm/plot-posterior-1.png)<!-- -->

The plot above shows how the model starts to converge on a smaller range
of plausible values for
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda").
Initially our prior was very wide but after fitting to the observed data
we start to get a better estimate.

### Estimate sumamry statistics from the posterior

What is the average observed value of elevator failures in your
building?

``` r
summarize(failures, mean(you))
```

    ## # A tibble: 1 x 1
    ##   `mean(you)`
    ##         <dbl>
    ## 1           3

What does our model estimate the average should be?

``` r
summarize(posterior_samples, mean(lambda))
```

    ## # A tibble: 1 x 1
    ##   `mean(lambda)`
    ##            <dbl>
    ## 1           3.09

What are the 90% credible intervals- the region that the true value of
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda")
has a 90% chance of lying within? We can calculate the 5% and 95%
quantiles with the `quantile()` function:

``` r
quantile(posterior_samples$lambda, c(0.05, 0.95))
```

    ##       5%      95% 
    ## 1.958205 4.409724

### Challenge: use your model to make an actual decision

Let’s say that the elevator company sells service contracts for
repairing broken elevators:

  - You can prepay for ![N](https://latex.codecogs.com/png.latex?N "N")
    service visits per year, at a cost of ![N \\times
    \\$1000](https://latex.codecogs.com/png.latex?N%20%5Ctimes%20%5C%241000
    "N \\times \\$1000") (whether or not you use them all)
  - Non-prepaid service visits cost $1500

**Use your model to predict the value of
![N](https://latex.codecogs.com/png.latex?N "N") that will minimize
expected cost**

Suggested approach: write a function that inputs the number of prepaid
visits and the number of failures for a given year, and outputs the
total cost.

``` r
#' Compute cost of services
#' @param num_failures number of elevator failures
#' @param num_prepaid number of prepaid service visits
cost_function <- function(num_failures, num_prepaid){
    # REMOVE CODE FOR LAB
    ifelse(num_failures <= num_prepaid,
           num_prepaid*1000,
           num_prepaid*1000 + (num_failures - num_prepaid)*1500
    )
}
```

You can run the following code chunk to check that your cost function
was defined correctly. You will get an error if it doesn’t work, and a
positive message otherwise.

    ## [1] "You are brilliant!"

The posterior samples we drew are values of
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda"),
but we need actual failure counts for our cost function. For any
![\\lambda\_{i} \\sim P(\\lambda
|x)](https://latex.codecogs.com/png.latex?%5Clambda_%7Bi%7D%20%5Csim%20P%28%5Clambda%20%7Cx%29
"\\lambda_{i} \\sim P(\\lambda |x)"), we can draw a failure count
![y\_{i} \\sim
Poisson(\\lambda\_{i})](https://latex.codecogs.com/png.latex?y_%7Bi%7D%20%5Csim%20Poisson%28%5Clambda_%7Bi%7D%29
"y_{i} \\sim Poisson(\\lambda_{i})") (that is, sampling from the
“posterior predictive distribution”).

Write the function `mean_cost()` that draws failures from the samples of
`\lambda` and calculates an average cost given a number of prepaid
service visits.

``` r
mean_cost <- function(samples, num_prepaid) {
    # REMOVE CODE FOR LAB
    
    # 1. Draw samples of number of failures from the posterior
    # The `rpois()` function will draw random samples from a Poisson distribution
    pois_draws <- rpois(length(samples), samples)
    
    # 2. Convert number of failures to cost based on num failures and num prepaid 
    cost_draws <- cost_function(pois_draws, num_prepaid)
    
    # 3. Calculate average cost over all the draws
    mean(cost_draws)
}
```

Run the code chunk below to test that your function returns the correct
values.

    ## [1] "You are perfect!"

We can use these samples with our cost function to estimate the expected
cost of different choices for
![num\_prepaid](https://latex.codecogs.com/png.latex?num_prepaid
"num_prepaid"). Using the `mean_cost()` function you created above,
create a vector of `cost_values` by varying `num_prepaid` between 1 and
10.

``` r
# a for loop is also fine
cost_values <- map_dbl(0:10, function(n) mean_cost(posterior_samples$lambda, n))
```

We then look for a minimum in our expected costs by plotting it

``` r
expected_costs <- tibble(n = 0:10, cost = cost_values)
ggplot(expected_costs, aes(x = n, y = cost)) +
    geom_line() +
    geom_point()
```

![](01c_elevator_repair_files/figure-gfm/plot-expected-costs-1.png)<!-- -->

### Challenge: reuse your analysis to answer a harder question

Our original dataset contained the historical counts of elevator
failures in your building, as well as buildings where three of your
friends work. Could you save money if the four of you combined forces
with a single shared service plan, or are you better off with four
separate plans?

<span style="color:red">Delete code for this entire section of the
lab.</span>

``` r
friend_names <- c('you', 'friend1','friend2','friend3')
```

``` r
# iterate over all friends and calculate minimum cost
min_costs <- map_dbl(friend_names, function(f) {
    # data for friend
    data <- list(
        N = nrow(failures),
        y = failures[[f]]
    )
    
    # sample from model with this data
    fit <- sampling(model, data, iter = 10000, chains = 4)
    posterior_samples <- as.data.frame(fit)
    posterior_samples <- as_tibble(posterior_samples)
    lambda_samples <- posterior_samples$lambda
    
    # return min cost
    cost_values <- map_dbl(0:10, function(n) mean_cost(lambda_samples, n))
    min(cost_values)
})
```

The `min_costs` represent the minimum (optimal) amount a person would
expect to pay elevator service.

``` r
min_costs
```

    ## [1] 4053.350 5085.900 4010.300 2983.675

Using these values we can calculate the total the elevator service would
expect to receive if each person paid individually.

``` r
# Expected cost for independent service contracts
sum(min_costs)
```

    ## [1] 16133.23

But what about if the individuals combined forces and bought the service
together? How much would this cost?

``` r
total_failures <- rowSums(failures)
total_failures
```

    ## [1] 14  8  9 14 15

``` r
# combined data
data <- list(
    N = length(total_failures),
    y = total_failures
)

# sample from model with this data
fit <- sampling(model, data, iter = 10000, chains = 4)
lambda_samples <- as.data.frame(fit)$lambda

# return min cost
shared_min_cost <- min(map_dbl(0:10, function(n) mean_cost(lambda_samples, n)))
```

``` r
# Expected Cost for risk pooling
shared_min_cost
```

    ## [1] 13200.98

As we can see, it costs less to for the friends to pool their resources
together. But would they actually do it? What would friend3 say about
this arrangement?
