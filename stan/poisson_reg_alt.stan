// poisson regression
data {
  int<lower=1> N;       // number of observations
  int<lower=1> K;       // number of variables/predictors/features
  matrix[N,K] x;        // matrix of explanatory variables/predictor matrix/features
  int<lower=0> y[N];    // count outcome vector
}
parameters {
  vector[K] beta;       // regression coefficients
}
model {
  // priors
  beta ~ student_t(4,0,1);

  // likelihood
  y ~ poisson_log(x * beta);
}
generated quantities {
  int y_hat[N];    // simulated values from the posterior

  // sample from poisson distribution
  for (i in 1:N) {
    y_hat[i] = poisson_log_rng(x[i] * beta);
  }
}
