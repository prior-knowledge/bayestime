// generate data from the priors of the normal model
// example 2.13 from Jackman
data {
  // *** NO DATA ***
}
parameters {
  real mu;              // prior mean
  real<lower=0> sigma;  // prior variance
}
model {
  // sample from priors
  mu ~ normal(0,20);
  sigma ~ gamma(3.25,0.5);
}
generated quantities {
  real y_sim;    // simulated values from the posterior

  y_sim = normal_rng(mu,sigma); // sample from normal distribution
}
