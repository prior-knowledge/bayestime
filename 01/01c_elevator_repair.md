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
library(rstan)
library(ggplot2)

options(mc.cores = parallel::detectCores())
rstan_options(auto_write=TRUE)
```

### Load the data

``` r
failures <- read.csv('elevator_failures.csv')
failures
```

    ##   you friend1 friend2 friend3
    ## 1   2       6       4       2
    ## 2   2       1       2       3
    ## 3   3       4       2       0
    ## 4   4       4       4       2
    ## 5   4       5       3       3

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
a <- 2
b <- 2
prior_samples <- rgamma(n=1000,shape=a,scale=b)
hist(prior_samples,100)
```

![](01c_elevator_repair_files/figure-gfm/plot-prior-1.png)<!-- -->

Now build the stan model:

``` r
model_code = "
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

``` r
model <- stan_model(model_code=model_code)
```

### Draw samples from the posterior

Run inference on the data from your building.

``` r
data <- list(
    N=nrow(failures),
    y=failures$you
)
```

``` r
fit <- sampling(object=model, data=data, iter=10000,chains=4)
fit
```

``` r
posterior_samples <- extract(fit)$lam
dim(posterior_samples)
```

    ## [1] 20000

``` r
# creating a dataframe to nicely use ggplot
prior_post <- data.frame('sample'=c(rep('prior',length(prior_samples)),rep('posterior',length(posterior_samples))),
                         'value'=c(prior_samples,posterior_samples))
g <- ggplot(prior_post, aes(x=value,stat(density),fill=sample))
g + geom_histogram(bins=100, position='identity',alpha=0.7) + 
    theme(legend.justification=c(1,1), legend.position=c(1,1), legend.title=element_blank())
```

![](01c_elevator_repair_files/figure-gfm/plot-posterior-1.png)<!-- -->

### Find the mean and 90% credible interval of the average number of failures per year¶

``` r
mean(posterior_samples)
```

    ## [1] 3.096126

``` r
paste("95 percent:", quantile(posterior_samples,0.95))
```

    ## [1] "95 percent: 4.45227455272852"

``` r
paste("5 percent:", quantile(posterior_samples, 0.05))
```

    ## [1] "5 percent: 1.95953372135962"

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
cost_function <- function(num_failures,n){
    # REMOVE CODE FOR LAB
    if (num_failures <= n) {
        cost <- n*1000
    } else {
        cost <- (n*1000 + (num_failures-n)*1500)
    }
    return(cost)
}
```

``` r
cost_function_returns_correct_values <- function(){
    print(cost_function(0,1) == 1000)
    print(cost_function(1,1) == 1000)
    print(cost_function(3,2) == 3500)
}
```

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

We can use these samples with our cost function to estimate the expected
cost of different choices for
![N](https://latex.codecogs.com/png.latex?N "N") (you can do this
brute-force style with a for loop or two; it doesn’t have to be pretty).

<span style="color:red">Remove code for lab.</span>

``` r
expected_costs <- data.frame('cost'=as.numeric())
for (i in 1:10) {
    pois_draws <- sapply(posterior_samples, function(x) rpois(1,x))
    expectation_value <- mean(sapply(pois_draws, function(x) cost_function(x,i)))
    expected_costs[i,1] <- expectation_value
}
```

We then look for a minimum in our expected costs.

``` r
g <- ggplot(expected_costs, aes(x=1:10,y=cost))
g + geom_line() + geom_point()
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
min_cost <- list('you'=min(expected_costs))
```

``` r
for(f in c('friend1','friend2','friend3')){
    data <- list(
        N=nrow(failures),
        y=failures[[f]]
        )
    fit <- sampling(object=model, data=data, iter=10000,chains=4)
    posterior_samples <- extract(fit)$lam 
    expected_costs_f <- data.frame('cost'=as.numeric())
    
    for (i in 1:10) {
        pois_draws <- sapply(posterior_samples, function(x) rpois(1,x))
        expectation_value <- mean(sapply(pois_draws, function(x) cost_function(x,i)))
        expected_costs_f[i,1] <- expectation_value
    }
    min_cost[f] <- min(expected_costs_f)
}
```

``` r
min_cost
```

    ## $you
    ## [1] 4029.275
    ## 
    ## $friend1
    ## [1] 5141.25
    ## 
    ## $friend2
    ## [1] 4031.9
    ## 
    ## $friend3
    ## [1] 2947.375

``` r
total_failures <- apply(failures, 1, sum)
total_failures
```

    ## [1] 14  8  9 14 15

``` r
fit <- sampling(object=model, data=list(y=total_failures,N=nrow(failures)), iter=10000,chains=4)
posterior_samples <- extract(fit)$lam 
expected_costs_s <- data.frame('cost'=as.numeric())

for (i in 1:10) {
    pois_draws <- sapply(posterior_samples, function(x) rpois(1,x))
    expectation_value <- mean(sapply(pois_draws, function(x) cost_function(x,i)))
    expected_costs_s[i,1] <- expectation_value
}
shared_min_cost <- min(expected_costs_s)
```

``` r
# Expected Cost for risk pooling
shared_min_cost
```

    ## [1] 13203.38

``` r
# Expected cost for independent service contracts
sum(unlist(min_cost))
```

    ## [1] 16149.8
