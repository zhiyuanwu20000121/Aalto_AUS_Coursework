data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
}

parameters {
  real mu;  // Mean of prior for diet-wise mean weights
  real<lower=0> tau;  // Standard deviation of prior for diet-wise mean weights
  vector[N_diets] mean_diet;  // Diet-wise mean weights
  vector<lower=0>[N_diets] sd_diet;  // Diet-wise standard deviations
}

model {
  // Priors
  mu ~ normal(120, 13.33);  // Prior for the mean of diet-wise mean weights
  tau ~ exponential(0.02);  // Prior for the standard deviation of diet-wise mean weights
  mean_diet ~ normal(mu, tau);  // Diet-wise mean weights
  sd_diet ~ exponential(0.02);  // Diet-wise standard deviations

  // Likelihood
  for (obs in 1:N_observations) {
    weight[obs] ~ normal(mean_diet[diet_idx[obs]], sd_diet[diet_idx[obs]]);
  }
}

generated quantities {
  real weight_pred;
  real mean_five;
  real sd_diets = sd_diet[4];
  real new_diet_mean;
  real sigma;
  sigma = mean(sd_diet);
  new_diet_mean = normal_rng(mu, tau);
  weight_pred = normal_rng(mean_diet[4], sd_diet[4]);
  mean_five = normal_rng(new_diet_mean, sigma);
}
