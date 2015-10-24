require('MASS')

# R is the correlation matrix of n normal random variables.
# v is drawn from a multivariate normal distribution.
gaussian_copula <- function(v, R){
  (1 / sqrt(det(R))) * exp(-0.5 * 
          t(qnorm(v)) %*% (ginv(R) - diag(dim(R)[1])) %*% as.matrix(qnorm(v)))
}

# Test.
normal <- matrix(rnorm(100), ncol=5)
correlation <- cor(normal)

x <- NULL
for (i in 1:500)
  x <- c(x, gaussian_copula(pnorm(rnorm(5)), correlation))

truehist(x)