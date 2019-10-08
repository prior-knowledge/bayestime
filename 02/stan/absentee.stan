// normal model to fit on absentee vote dataset
// example 2.13 from Jackman
data {
  int<lower=1> N; // number of datapoints
  real y[N];      // random variable
}
parameters {
  real mu;              // prior mean
  real<lower=0> sigma;  // prior variance
}
model {
  // sample from priors
  mu ~ normal(0,20);
  sigma ~ gamma(3.25,0.5);

  // specify likelihood
  y ~ normal(mu,sigma);
}
generated quantities {
  real y_sim;    // simulated values from the posterior

  y_sim = normal_rng(mu,sigma); // sample from normal distribution
}
