
# Given: Positive integers n<=100 and m<=20.
# 
# Return: The total number of pairs of rabbits that will remain after the n-th month if all rabbits live for m months.
# 
# Sample Dataset
# 
# 6 3
# Sample Output
# 
# 4


install.packages("gmp") # for really big integers
library(gmp)



fibd <- function(m,n) {

population <- as.bigz(c(1, rep(0,n-1)))

for (month in 2:m) {
  population <- c(sum(population[2:n]), population[1:n-1])

}
return(sum(population))

}

fibd(100,17)


