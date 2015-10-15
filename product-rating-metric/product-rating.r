measure <- function(x) { mean(x) / sd(c(x, 0, 1)) }
A <- c(rep(1, 97), rep(0, 3))
B <- c(1, 1, 1)
c(measure(A), measure(B))
