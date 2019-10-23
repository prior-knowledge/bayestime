// multilevel model for particulate matter
// assume non-centered data
data {
  int<lower=1> N;                   // number of observations
  int<lower=1> R;                   // number of super regions
  int<lower=1,upper=R> region[N];   // region IDs
  vector[N] log_sat;                // log of satellite measurements
  vector[N] log_pm;                 // log of ground PM_2.5 measurements
}
parameters {
  real beta0;                       // global intercept
  real beta1;                       // global slope
  vector[R] beta0_region_raw;       // 'raw' region intercept offsets for NCP
  vector[R] beta1_region_raw;       // 'raw' region slope offsets for NCP
  real<lower=0> tau0;               // sd of beta0_region
  real<lower=0> tau1;               // sd of beta1_region
  real<lower=0> sigma;              // error sd for Gaussian likelihood
}
model {
  // mean of likelihood
  vector[N] mu;

  // priors
  beta0 ~ normal(0,1);
  beta1 ~ normal(1,1);
  tau0 ~ normal(0,1);
  tau1 ~ normal(0,1);
  beta0_region_raw ~ normal(0,1);
  beta1_region_raw ~ normal(0,1);
  sigma ~ normal(0,1);

  // construct mean of each observation
  // each region has a unique intercept and slope...
  // ...so we iterate through the observations and
  // lookup the betaX_region that matches the region
  // of observation i
  for (i in 1:N) {
    mu[i] = (beta0 + beta0_region_raw[region[i]]) + (beta1 + beta1_region_raw[region[i]]) * log_sat[i];
  }

  // likelihood
  log_pm ~ normal(mu, sigma);
}
generated quantities {
  vector[N] log_lik;    // pointwise log-likelihood for LOO
  vector[N] log_pm_rep; // replications from posterior predictive dist

  for (i in 1:N) {
    // what's the mean for observation i?
    real log_pm_hat_n;
    log_pm_hat_n  = (beta0 + beta0_region_raw[region[i]]) + (beta1 + beta1_region_raw[region[i]]) * log_sat[i];

    // now compute log likelihood and simulate from posterior
    log_lik[i] = normal_lpdf(log_pm[i] | log_pm_hat_n, sigma);
    log_pm_rep[i] = normal_rng(log_pm_hat_n, sigma);
  }
}
