

mc_sim_modest = foo_function

N = seq(1000,2500,by=300)
int_grand_mean = seq(-2,2,by=0.5)
# beta_log_or = seq(-2,2,by=0.5)
beta_log_or = log(seq(0.01,5,by=0.1))

input_grid = expand.grid(N=N,int_grand_mean=int_grand_mean,beta_log_or=beta_log_or)


rsac_func = function(foo_function,input_grid,n_rep=50){
  # replicate each split-apply-combine
  mc_sim = replicate(n_rep,  # number of mc simulations
                     do.call(mapply,c(foo_function,input_grid))
  )
  
}

