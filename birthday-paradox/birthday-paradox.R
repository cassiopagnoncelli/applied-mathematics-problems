#
# Birthday paradox simulation.
#
# With 23 people in a room, the probability that at least two birthdays
# colide is slightly over 50%. As for 70 people the result soares to 99.9%.
# >50% prob is reached with 23 people in a room
#

# PDF.
p <- function(n) { 1 - factorial(n) * choose(365, n) / 365^n }
plot(p(1:80), t='l', main='Probability density function', ylab='Density', xlab='People')
abline(h=c(0,1))

# Simulation.
trials <- 10000

calc <- function(num_people, reps=trials) {
  unlist(Map(function(x){
    anyDuplicated(sort(sample(1:365, num_people, rep=T))) > 0
  }, 1:reps))
}

simulated <- c(sum(calc(23)) / trials, sum(calc(70)) / trials)
actual <- c(p(23), p(70))
data.frame(simulated, actual, row.names=c('n=23', 'n=70'))

#
# Drawing with replacement k values out of a set of n different and equally
# likely numbers, the expected number of unique draws is n(1-e^(-k/n)).
# Hence, the proportion of repeated draws is e^(-k/n).
#
plot(1-exp(-seq(0, 1, 0.001)), t='l', ylim=c(0,1),
     ylab='Expected uniques (%)', xlab='Size',
     main='Expected uniques in drawing with replacement')
abline(h=1-exp(-1))

plot(1:365, t='h', col='red', ylab='Unique draws', xlab='Sample size',
     main='Expected number of unique draws')
lines(365*(1-exp(-1:-365/365)), t='h', col='blue')

plot(1:365, t='h', ylab='Expected repetitions', xlab='Sample size',
     main='Expected repetitions in sampling with repetition', col='gray')
lines(1:365 - 365*(1-exp(-1:-365/365)), col='red', t='h')
