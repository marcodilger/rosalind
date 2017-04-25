# Speeding Up Motif Finding / Knuth-Morris-Pratt algorithm (KMP)
# 
# prefix of a length nn string ss is a substring s[1:j]s[1:j]; a suffix of ss is a substring s[k:n]s[k:n].
# 
# The failure array of ss is an array PP of length nn for which P[k]P[k] is the length of the longest substring s[j:k]s[j:k] that is equal to some prefix s[1:k−j+1]s[1:k−j+1], where jj cannot equal 11 (otherwise, P[k]P[k] would always equal kk). By convention, P[1]=0P[1]=0.
# 
# Given: A DNA string ss (of length at most 100 kbp) in FASTA format.
# 
# Return: The failure array of ss.
# 
# Sample Dataset
# 
# >Rosalind_87
# CAGCATGGTATCACAGCAGAG
# Sample Output
# 
# 0 0 0 1 2 0 0 0 0 0 0 1 2 1 2 3 4 5 3 0 0
# 
# pseudocode
# 
# go through the DNA string[k elements], for every k check
#   the amount of matches in ( string[j:k] vs string[1:k-j+1] with j = 2,3,...k) -> length of biggest prefix/suffix pair
#   stop after j = length(k-1) + 1, because length can never be >+1 than the length of the previous k
# save length in growing vector (but should be possible without loops)
# 
# 
 
 
# laid out code, without loops/vectorization

dna <- "CAGCATGGTATCACAGCAGAG"
p <- 0 # P[1] = 0 by definitions

# start with k = 2
substring <- substr(dna, 2, 2) # k=2, j=2 
prefix <- substr(dna, 1, 1) # k=2, j=2

length <- max(nchar(intersect(substring, prefix)))
p <- c(p,ifelse(is.integer(length), length, 0))

# k = 3, j = max 2 different values (because p[2]=0): 3,2
substring1 <- substr(dna, 2, 3) # k=3, j=2
substring2 <- substr(dna, 3, 3) # k=3, j=3
substring <- c(substring1, substring2)

prefix1 <- substr(dna, 1, 1) # k=3, j=3
prefix2 <- substr(dna, 1, 2) # k=3, j=2

length <- max(nchar(intersect(substring, prefix)))
p <- c(p,ifelse(is.integer(length), length, 0))


# k = 4, j = again only max 2 different values (because p[3]=0): 4,3

substring1 <- substr(dna, 3, 4) # k=4, j=3
substring2 <- substr(dna, 4, 4) # k=4, j=4
substring <- c(substring1, substring2)

prefix1 <- substr(dna, 1, 1) # k=4, j=4
prefix2 <- substr(dna, 1, 2) # k=4, j=3

prefix <- c(prefix1, prefix2)

length <- max(nchar(intersect(substring, prefix)))
p <- c(p,ifelse(is.integer(length), length, 0))

# k = 5, j nox max 3 different values (because p[4]=1): 5,4,3

substring1 <- substr(dna, 5, 5) # k=5, j=5
substring2 <- substr(dna, 4, 5) # k=5, j=4
substring3 <- substr(dna, 3, 5) # k=5, j=3
substring <- c(substring1, substring2, substring3)

prefix1 <- substr(dna, 1, 1) # k=5, j=5
prefix2 <- substr(dna, 1, 2) # k=5, j=4
prefix3 <- substr(dna, 1, 3) # k=5, j=3

prefix <- c(prefix1, prefix2, prefix3)
length <- max(nchar(intersect(substring, prefix)))
p <- c(p,ifelse(is.integer(length), length, 0))

#### vektorisierung
# substring und prefix vergleich ist immer gleich lang, 
# d.h. es kann immer paarweise verglichen werden
# 
2:nchar(dna) # jedes k {



k <- 17
p[k] <- 0
test.seq <- seq(k, by = -1, length.out=p[k-1] + 1)

sapply(test.seq, function(j) {
  substring <- substr(dna, j, k)
  prefix <- substr(dna, 1, k-j+1)
  if (substring == prefix) {
  p[k] <<- nchar(substring)
  }
  })
  
#}
