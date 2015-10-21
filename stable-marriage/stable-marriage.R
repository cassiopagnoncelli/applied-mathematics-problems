# Algorithm: free men not having expired their proposals propose
# to women; if they (women) are free then they marry, otherwise
# (she is married) she chooses the best man for her leaving the
# former alone.
#

# Men and women.
men.names <- c('marcelo', 'julio', 'adao', 'wilmar', 'pedro')
women.names <- c('mary', 'elize', 'kath', 'lesley', 'telma')

n <- length(men.names)

# Women rank men.
women.likes.grades <- matrix(runif(25), ncol=5)
colnames(women.likes.grades) <- men.names
rownames(women.likes.grades) <- women.names
women.likes.grades

women.likes.order <- t(apply(apply(women.likes.grades, 1, order), 2, rev))
women.likes.order

women.likes.names <- matrix(men.names[women.likes.order], ncol=n)
rownames(women.likes.names) <- women.names
women.likes.names
women.ranking <- women.likes.names

women.likes.grades
women.ranking

# Men rank women.
men.likes.grades <- matrix(runif(25), ncol=5)
colnames(men.likes.grades) <- women.names
rownames(men.likes.grades) <- men.names
men.likes.grades

men.likes.order <- t(apply(apply(men.likes.grades, 1, order), 2, rev))
men.likes.order

men.likes.names <- matrix(women.names[men.likes.order], ncol=n)
rownames(men.likes.names) <- men.names
men.likes.names
men.ranking <- men.likes.names

men.likes.grades
men.ranking

# Stable matching.
w_marries <- matrix(rep(0, n)); rownames(w_marries) <- women.names
m_marries <- matrix(rep(0, n)); rownames(m_marries) <- men.names

proposals <- matrix(rep(0, n)); rownames(proposals) <- men.names

while (min(m_marries) == 0 && proposals[which.min(m_marries)] < n) {
  m <- which.min(m_marries)
  proposals[m] <- proposals[m] + 1
  w <- men.likes.order[m, proposals[m]]
  
  # w is free implies (m,w) engage
  if (w_marries[w] == 0) {
    w_marries[w] <- m
    m_marries[m] <- w
  } else {
    m_line <- w_marries[w]
    if (women.likes.grades[w, men.names[m]] > women.likes.grades[w, men.names[m_line]]) {
      w_marries[w] <- m
      m_marries[m] <- w
      m_marries[m_line] <- 0
    }
  }
}

# Results.
result <- data.frame(t(women.names))
colnames(result) <- men.names[w_marries]
rownames(result) <- c('marries')

# Report.
women.ranking
men.ranking
result
