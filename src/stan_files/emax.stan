data{
  int<lower = 1> N;
  vector<lower = 0>[N] exposure;
  vector[N] response;

  // Fixed parameters
  int<lower=0,upper=1> gamma_fix_flg;
  int<lower=0,upper=1> e0_fix_flg;
  real<lower=0> gamma_fix_value;
  real e0_fix_value;

  // priors
  //// mu
  real prior_emax_mu;
  real<lower=0> prior_ec50_mu;
  real<lower=0> prior_gamma_mu;
  real prior_e0_mu;
  real<lower=0> prior_sigma_mu;
  //// sigma
  real<lower=0> prior_emax_sig;
  real<lower=0> prior_ec50_sig;
  real<lower=0> prior_gamma_sig;
  real<lower=0> prior_e0_sig;
  real<lower=0> prior_sigma_sig;
}

parameters{
  real emax;
  real<lower = 0> ec50;
  real e0_par[1-e0_fix_flg];
  real<lower = 0> gamma_par[1-gamma_fix_flg];

  real<lower = 0> sigma;
}

transformed parameters{
  vector[N] respHat;
  vector[N] exposure_exp;

  real gamma;
  real e0;

  gamma = gamma_fix_flg ? gamma_fix_value : gamma_par[1];
  e0    = e0_fix_flg    ? e0_fix_value   : e0_par[1];

  for(i in 1:N) exposure_exp[i] = exposure[i]^gamma;

  respHat = e0 + emax * exposure_exp ./ (ec50^gamma + exposure_exp);
}

model{
  response ~ normal(respHat, sigma);

  emax       ~ normal(prior_emax_mu,  prior_emax_sig);
  ec50       ~ normal(prior_ec50_mu,  prior_ec50_sig);
  gamma_par  ~ normal(prior_gamma_mu, prior_gamma_sig);
  e0_par     ~ normal(prior_e0_mu,    prior_e0_sig);
  sigma      ~ normal(prior_sigma_mu, prior_sigma_sig);
}

generated quantities {
  vector[N] log_lik;
  for (n in 1:N) log_lik[n] = normal_lpdf(response[n]| respHat[n], sigma);
}
