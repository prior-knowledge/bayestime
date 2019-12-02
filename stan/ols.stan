// generic ols model
data {
  // data
  int<lower=1> N;       // number of observations
  int<lower=1> K;       // number of variables/predictors/features
  matrix[N,K] x;        // matrix of explanatory variables/predictor matrix/features
  vector[N] y;          // outcome vector

  // hyperpriors for parameters (student_t)
  real mu_alpha;
  real sigma_alpha;
  real nu_alpha;
  real mu_beta;
  real sigma_beta;
  real nu_beta;
  real mu_sigma;
  real sigma_sigma;
  real nu_sigma;

  // just sample from prior?
  // if sample_prior = 1, then just sample from prior
  int<lower=0,upper=1> sample_prior;
}
parameters {
  real alpha;           // regression coefficients
  vector[K] beta;       // regression coefficients
  real<lower=0> sigma;  // standard deviation of normal distr
}
model {
  // priors
  alpha ~ student_t(nu_alpha,mu_alpha,sigma_alpha);
  beta ~ student_t(nu_beta,mu_beta,sigma_beta);
  sigma ~ student_t(nu_sigma,mu_sigma,sigma_sigma);

  // likelihood
  if (sample_prior == 0) {
    y ~ normal(x * beta, sigma);
  }
}
generated quantities {
  vector[N] y_hat;      // vector of predicted outcomes
  vector[N] loglik;     // vector of log likelihood for checks

  for (i in 1:N) {
      y_hat[i] = normal_rng(x[i] * beta, sigma);
      loglik[i] = normal_lpdf(y[i] | x[i] * beta, sigma);
  }
}
