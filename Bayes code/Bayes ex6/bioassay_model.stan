data {
  int<lower=0> N;             // Number of data points (doses)
  vector[N] x;                // Dose amounts
  int<lower=0> n[N];          // Number of trials for each dose
  int y[N];                   // Number of successes (deaths) for each dose
}

parameters {
  vector[2] theta;  // theta[1] = alpha, theta[2] = beta
}

model {
  vector[N] logit_p;

  // Priors
  theta ~ multi_normal([0, 10]', [[4, 12], [12, 100]]);  // Using the given mu and Sigma
  
  // Likelihood
  for (i in 1:N) {
    logit_p[i] = theta[1] + theta[2] * x[i];
    y[i] ~ binomial_logit(n[i], logit_p[i]);
  }
}
