// fit a poisson model to the number of HWPDs in Dubuqe
data {
  int<lower=1> N; // number of datapoints
  int hwpd[N];    // random variable
}
parameters {
  real<lower=0> lambda;  // rate of events
}
model {
  // priors
  lambda ~ normal(0,5);

  // likelihood
  hwpd ~ poisson(lambda);
}
generated quantities {
  int hwpd_sim[N];    // simulated values from the posterior

  // sample from poisson distribution
  for (i in 1:N) {
    hwpd_sim[i] = poisson_rng(lambda); 
  }
}
