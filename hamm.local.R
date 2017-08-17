Given two strings s and t of equal length, the Hamming distance between s and t, denoted dH(s,t), is the number of corresponding symbols that differ in s and t. See Figure 2.

Given: Two DNA strings s and t of equal length (not exceeding 1 kbp).

Return: The Hamming distance dH(s,t).

Sample Dataset

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT

Sample Output

7



#### Einlesen ####
require(stringr)
lines<-readLines("data/rosalind_hamm.txt")
splits<-str_split(lines,"")
mutations <- sum(!(splits[[1]]==splits[[2]]))

##correct