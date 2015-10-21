# Pick the first best candidate upon rejecting the first 37% (=1/e).
choice <- function(v) {
  n <- length(v)
  threshold <- ceiling(exp(-1) * n)
  best <- max(v[1:threshold])
  for (i in (threshold+1):n) { if (v[i] > best) return(i) }
  return(0)
}

# Reports.
result <- function(m, suppress.matrix=T) {
  choiceMade <- apply(m, 1, choice)
  answerPosition <- apply(m, 1, which.max)
  answerMax <- apply(m, 1, which.max)
  
  res <- data.frame(choiceMade, answerPosition, answerMax)
  
  scope <- res[choiceMade > 0,]
  hits <- scope[,1] == scope[,2]
  
  if (suppress.matrix) { show.res <- matrix(0) } else { show.res <- res }
  return(
    list(matrix=show.res,
         interviews=dim(m)[1],
         hires=length(hits),
         hires_ratio=length(hits)/dim(m)[1],
         optimal_hire_ratio=sum(hits)/length(hits))
  )
}

# Simulation.
sample_size <- 1000

opt_hire <- NULL
hires_ratio <- NULL
for (cols in 2:200) {
  m <- matrix(runif(cols * sample_size), ncol=cols)
  r <- result(m)
  opt_hire <- c(opt_hire, r$optimal_hire_ratio)
  hires_ratio <- c(hires_ratio, r$hires_ratio)
}

plot(100 * opt_hire, t='l', ylim=c(0,100), col='black',
     ylab='Optimal hire ratio', xlab='Number of candidates',
     main='The secretary problem')
lines(100 * hires_ratio, t='l', ylim=c(0, 100), col='red')
mtext('Solved with the Odds algorithm')
legend('topright', legend=c('Correct hires (%)', 'Effective hires (%)'),
       col=c('black', 'red'), lty=c(1,1))
abline(h=c(50, 60, 70), col='gray', lty='dashed')