// fit a zero-inflated poisson model to the number of HWPDs in Dubuqe
data {
  int<lower=1> N; // number of datapoints
  int hwpd[N];    // random variable
}
parameters {
  real<lower=0> lambda;         // rate of events
  real<lower=0, upper=1> theta; // probability of a zero
}
model {
  // priors
  lambda ~ normal(0,5);
  theta ~ beta(1,1);

  // likelihood
  // Observational model that mixes a Poisson with excess zeros
  for (n in 1:N) {
    real lpdf = poisson_lpmf(hwpd[n] | lambda);
    if (hwpd[n] == 0)
      target += log_mix(theta, 0, lpdf);
    else
      target += log(1 - theta) + lpdf;
  }
}
generated quantities {
    // Simulate data from posterior
    int hwpd_sim[N] = rep_array(0, N);
    for (n in 1:N) {
      if (!bernoulli_rng(theta))
        hwpd_sim[n] = poisson_rng(lambda);
    }
}
