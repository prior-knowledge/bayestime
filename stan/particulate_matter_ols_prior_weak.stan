// ols model for particulate matter
// generate from the prior
data {
  int<lower=1> N;       // number of observations
  vector[N] log_sat;    // log of satellite measurements
}
parameters {
  real beta0;           // global intercept
  real beta1;           // global slope
  real<lower=0> sigma;  // error sd for Gaussian likelihood
}
model {
  // priors
  beta0 ~ normal(0, 100);
  beta1 ~ normal(0, 100);
  sigma ~ normal(0, 100);
}
generated quantities {
  vector[N] log_pm_prior; // vector of data generated from prior

  for (i in 1:N) {
      log_pm_prior[i] = normal_rng(beta0 + beta1 * log_sat[i],sigma);
  }
}
