// generate data from the priors of the ROCK THE VOTE model
// example X.XX from Jackman
data {
  int N;                      // number of markets
  int reg_vtr[N];             // number of registered voters in each market
  int votes[N];               // number of people who voted in each market
  int<lower=0,upper=1> T[N];  // treatment indicator, 1 if treated, 0 otherwise
}
parameters {
  real alpha;             // overall turnout rate
  real delta;             // effect of treatment on turnout
}
model {
  // helper variable to hold each market's alpha
  real a[N];

  // sample from priors
  alpha ~ normal(0,1);
  delta ~ normal(0,1);

  // construct alpha for each market
  for (i in 1:N){
    a[i] = alpha + delta*T[i];
  }

  // likelihood
  votes ~ binomial_logit(reg_vtr,a);

}
generated quantities {
  real sim_votes[N];         // simulated values from the model
  real theta[N];

  for (i in 1:N){
    // construct binomial parameter for each market
    theta[i] = inv_logit(alpha + delta * T[i]);

    // simulate number of voters from binomial logit
    sim_votes[i] = binomial_rng(reg_vtr[i],theta[i]);
  }
}
