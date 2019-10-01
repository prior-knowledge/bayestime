Week 1 lab: Elevator Repair
================

<span style="color:red">Red things are python that still need to be
converted to R</span>

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
  - use posterior predictions about your model to \_\_\_

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

**Note:** <span style="color:red">rgamma uses (shape, scale) to
parameterize Gamma distribution; stan uses (alpha, beta) where
alpha=shape and beta=1/scale.</span> Example samples from a Gamma
distribution:

``` r
# generate random samples from a the gamma distribution
a <- 2
b <- 2
prior_samples <- rgamma(n = 1000, shape = a, scale = b)

# plot the prior samples
ggplot() + geom_histogram(aes(x = prior_samples), bins = 100)
```

![](01c_elevator_repair_files/figure-gfm/plot-prior-1.png)<!-- -->

Now define the stan model:

``` r
model_code <- "
data {
    int<lower=0> N;
    int<lower=0> y[N];
}
parameters {
    real<lower=0> lam;
}
model {
    lam ~ gamma(2,0.5); // SPECIFY YOUR PRIOR HYPERPARAMETERS HERE
    y ~ poisson(lam);
}
"
```

And compile it:

``` r
model <- stan_model(model_code=model_code)
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
our estimate for `lam`. We will run for 10,000 iterations on 4 parallel
chains.

``` r
fit <- sampling(model, data, iter = 10000, chains = 4)
```

``` r
fit
```

    ## Inference for Stan model: 8d995a2ffb9b91c6dd7356d07bf686f5.
    ## 4 chains, each with iter=10000; warmup=5000; thin=1; 
    ## post-warmup draws per chain=5000, total post-warmup draws=20000.
    ## 
    ##      mean se_mean   sd  2.5%  25%  50%  75% 97.5% n_eff Rhat
    ## lam  3.09    0.01 0.75  1.80 2.54 3.03 3.56  4.74  7346    1
    ## lp__ 1.67    0.01 0.72 -0.39 1.52 1.95 2.13  2.18  7602    1
    ## 
    ## Samples were drawn using NUTS(diag_e) at Mon Sep 30 20:05:47 2019.
    ## For each parameter, n_eff is a crude measure of effective sample size,
    ## and Rhat is the potential scale reduction factor on split chains (at 
    ## convergence, Rhat=1).

We can extract the samples from this procedure using the `extract()`
function.

``` r
posterior_samples <- extract(fit)$lam
dim(posterior_samples)
```

    ## [1] 20000

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
prior_results <- tibble(sample = "prior", value = prior_samples)
post_results <- tibble(sample = "posterior", value = posterior_samples)
results <- bind_rows(post_results, prior_results)

# plot a histogram
ggplot(results, aes(x = value, y = stat(density), fill = sample)) +
    geom_histogram(bins = 100, position = 'identity', alpha=0.7)
```

![](01c_elevator_repair_files/figure-gfm/plot-posterior-1.png)<!-- -->

The plot above shows how the model starts to converge on a smaller range
of plausible values for
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda").
Initially our prior was very wide but after fitting to the observed data
we start to get a better
estimate.

### Find the mean and 90% credible interval of the average number of failures per year¶

``` r
mean(posterior_samples)
```

    ## [1] 3.087125

We can calculate the 5% and 95% quantiles with the `quantile()`
function:

``` r
quantile(posterior_samples, c(0.05, 0.95))
```

    ##       5%      95% 
    ## 1.963590 4.428802

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
cost <- function(num_failures, num_prepaid){
    # REMOVE CODE FOR LAB
    # cost for prepaid failures
    prepaid_cost <- num_prepaid*1000
    
    # additional cost for failures not prepaid for
    adhoc_cost <- ifelse(num_failures <= num_prepaid, 0, (num_failures - num_prepaid)*1500)
    
    # combined cost
    prepaid_cost + adhoc_cost
}
```

    ## [1] "You are gnarly!"

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

<span style="color:red">Remove code for lab.</span>

``` r
mean_cost <- function(samples, num_prepaid) {
    # 1. Draw samples of number of failures from the posterior
    # The `rpois()` function will draw random samples from a Poisson distribution
    nsamples <- length(samples)
    pois_draws <- rpois(nsamples, samples)
    
    # 2. Convert number of failures to cost based on num failures and num prepaid 
    cost_draws <- cost(pois_draws, num_prepaid)
    
    # 3. Calculate average cost over all the draws
    mean(cost_draws)
}
```

Run the code chunk below to test that your function returns the correct
values.

    ## [1] "You are cool!"

We can use these samples with our cost function to estimate the expected
cost of different choices for
![num\_prepaid](https://latex.codecogs.com/png.latex?num_prepaid
"num_prepaid") (you can do this brute-force style with a for loop or
two; it doesn’t have to be pretty). Using the `mean_cost()` function you
created above, create a vector of `cost_values` by varying `num_prepaid`
between 1 and 10.

<span style="color:red">Remove code for
lab.</span>

``` r
cost_values <- map_dbl(1:10, function(n) mean_cost(posterior_samples, n))
```

We then look for a minimum in our expected costs by plotting it

``` r
expected_costs <- tibble(n = seq_along(cost_values), cost = cost_values)
ggplot(expected_costs, aes(x = n, y = cost)) +
    geom_line() +
    geom_point()
```

![](01c_elevator_repair_files/figure-gfm/plot-expected-costs-1.png)<!-- -->

We’ll verify our plot by using the function `min_cost()` that calculates
the expected costs for a range of values and returns the minimum one.

``` r
min_cost <- function(samples, ns = 1:10) {
    cost_values <- map_dbl(ns, function(n) mean_cost(samples, n))
    min(cost_values)
}

min_cost(posterior_samples, 1:10)
```

    ## [1] 4028

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
min_cost_values <- map_dbl(friend_names, function(f) {
    # data for friend
    data <- list(
        N = nrow(failures),
        y = failures[[f]]
    )
    
    # sample from model with this data
    fit <- sampling(model, data, iter = 10000, chains = 4)
    posterior_samples <- extract(fit)$lam 
    
    # return min cost
    min_cost(posterior_samples, 1:10)
})
```

The `min_cost_values` represent the minimum (optimal) amount a person
would expect to pay elevator service.

``` r
min_cost_values
```

    ## [1] 4033.175 5077.725 4039.625 2953.000

Using these values we can calculate the total the elevator service would
expect to receive if each person paid individually.

``` r
# Expected cost for independent service contracts
sum(min_cost_values)
```

    ## [1] 16103.53

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
posterior_samples <- extract(fit)$lam 

# return min cost
shared_min_cost <- min_cost(posterior_samples, 1:10)
```

``` r
# Expected Cost for risk pooling
shared_min_cost
```

    ## [1] 13201.12

As we can see, it costs less to for the friends to pool their resources
together. But would they actually do it? What would friend3 say about
this arrangement?
