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