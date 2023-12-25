data {
  int<lower=0> N_observations;
  int<lower=0> N_diets;
  array[N_observations] int diet_idx; // Pair observations to their diets.
  vector[N_observations] weight;
}

parameters {
  real mean_diet;
  real<lower=0> sd_diet;
}

model {
  // Priors
  mean_diet ~ normal(120, 13.33);
  sd_diet ~ exponential(0.02);

  // Likelihood
  weight ~ normal(mean_diet, sd_diet);
}

generated quantities {
  real weight_pred;
  real mean_five;
  weight_pred = normal_rng(mean_diet, sd_diet);
  mean_five = mean_diet;
}
