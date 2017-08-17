# Inferring Peptide from Full Spectrum
# 
# Say that we have a string ss containing tt as an internal substring, 
# so that there exist nonempty substrings s1s1 and s2s2 of ss 
# such that ss can be written as s1ts2s1ts2. A t-prefix contains all of s1s1 and 
# none of s2s2; likewise, a t-suffix contains all of s2s2 and none of s1s1.
# 
# Given: A list LL containing 2n+32n+3 positive real numbers (n≤100n≤100). The first number in LL is the parent mass of a peptide PP, and all other numbers represent the masses of some b-ions and y-ions of PP (in no particular order). You may assume that if the mass of a b-ion is present, then so is that of its complementary y-ion, and vice-versa.
# 
# Return: A protein string tt of length nn for which there exist two positive real numbers w1w1 and w2w2 such that for every prefix pp and suffix ss of tt, each of w(p)+w1w(p)+w1 and w(s)+w2w(s)+w2 is equal to an element of LL. (In other words, there exists a protein string whose tt-prefix and tt-suffix weights correspond to the non-parent mass values of LL.) If multiple solutions exist, you may output any one.
# 
# Sample Dataset
# 
# 1988.21104821
# 610.391039105
# 738.485999105
# 766.492149105
# 863.544909105
# 867.528589105
# 992.587499105
# 995.623549105
# 1120.6824591
# 1124.6661391
# 1221.7188991
# 1249.7250491
# 1377.8200091
# Sample Output
# 
# KEKEP
# 
# 
#  - the given fragments are from cuts somewhere in the middle of a hypothetical peptide 
#  with the mass of [first line of input]
#  
#  - the sequence of this middle part needs to be returned
#  
#  - b-ion (n terminus) and complementary y-ion are always both present in the input
#  
#  - if multiple solutions exist: any one is correct (probably because C and N termini can't be distinguished)
#  
#  

# pseudocode:

# sort fragments
# set biggest fragment as starting point
# search for first difference in fragment mass to all smaller fragments
# save Amino acid
# set next fragment start to remaining fragment from this time
# remove sister fragment
# remove all bigger fragments
# 
# repeat and grow lists of AS

accuracy <- 4
data <- as.numeric(readLines("data/rosalind_full.txt"))
frags <-  rev(sort(data[-1]))

repeat {
diffs <- frags[1] - frags[-1]
lost_aa <- mass_table[match(round(diffs, accuracy), round(mass_table[ ,2], accuracy)) ,1] #first round obsolete
peptide <<- c(peptide,lost_aa[which(!is.na(lost_aa))[1]])
frags <- frags[-(1:which(!is.na(lost_aa))[1])] #remove all frags that are bigger as the current resulting fragment
if (length(frags) < 2) { break }
}

solution <- paste(peptide[1:((length(data)-3)/2)], collapse = "")

write(solution, file = "full_solution.txt")
  