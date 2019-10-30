// generic ols model
data {
  int<lower=1> N;       // number of observations
  int<lower=1> K;       // number of variables/predictors/features
  matrix[N,K] x;        // matrix of explanatory variables/predictor matrix/features
  vector[N] y;          // outcome vector
}
parameters {
  vector[K] beta;       // regression coefficients
  real<lower=0> sigma;  // standard deviation of normal distr
}
model {
  // priors
  beta ~ student_t(4,0,1);
  sigma ~ student_t(4,0,2);

  // likelihood
  y ~ normal(x * beta, sigma);
}
generated quantities {
  vector[N] y_hat;      // vector of predicted outcomes
  vector[N] loglik;     // vector of log likelihood for checks

  for (i in 1:N) {
      y_hat[i] = normal_rng(x[i] * beta, sigma);
      loglik[i] = normal_lpdf(y[i] | x[i] * beta, sigma);
  }
}
