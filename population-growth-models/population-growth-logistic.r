# Logistic model.
N <- function(t, r, K, N0) { K / (1 + ((K-N0)/N0)*exp(-r*t)) }

# Params.
k = 2000       # carrying capacity
n0 = 100       # initial population
R = 0.1        # rate of increase

plot(N(1:100, R, k, n0), t='l', lwd=2, col='blue', ylim=c(0, k),
     main='Logistic model for population growth in an environment')
abline(h=k)
abline(h=0)