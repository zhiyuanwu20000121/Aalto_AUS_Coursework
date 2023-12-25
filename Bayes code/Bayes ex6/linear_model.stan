data {
    int<lower=0> N; 
    vector[N] x; 
    vector[N] y; 
    int<lower=0> no_predictions;
    vector[no_predictions] x_predictions; 
}

parameters {
    real alpha; 
    real beta; 
    real<lower=0> sigma; 
}

transformed parameters {
    vector[N] mu = alpha + beta * x; 
}

model {
    y ~ normal(mu, sigma); 
}

generated quantities {
    vector[no_predictions] mu_pred = alpha + beta * x_predictions;
    vector[no_predictions] y_pred;
    for (i in 1:no_predictions) {
        y_pred[i] = normal_rng(mu_pred[i], sigma);
    }
}
