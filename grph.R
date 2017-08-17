# problem grph

# Given: A collection of DNA strings in FASTA format having total length at most 10 kbp.

# Return: The adjacency list corresponding to O3O3. You may return edges in any order.
# 
# Sample Dataset
# 
# >Rosalind_0498
# AAATAAA
# >Rosalind_2391
# AAATTTT
# >Rosalind_2323
# TTTTCCC
# >Rosalind_0442
# AAATCCC
# >Rosalind_5013
# GGGTGGG
# Sample Output
# 
# Rosalind_0498 Rosalind_2391
# Rosalind_0498 Rosalind_0442
# Rosalind_2391 Rosalind_2323






library(stringr)
library(dplyr)

# fastq parsing from older problem (to be optimized...)

all_lines<-readLines("data/rosalind_grph.txt")
id_lines<-grep(">",all_lines)

nodes<- gsub(">", "",all_lines[id_lines])

sequences <- unlist(str_split(paste(gsub("^>.*$", " ",all_lines[2:length(all_lines)]), collapse="")," "))


prefix <-  str_sub(sequences, 1, 3)
suffix <- str_sub(sequences, nchar(sequences)-2, nchar(sequences))



adj <- data.frame("heads" = character(0), "tails" = character(0)) # initalizing an empty data.frame, to be appended in the loop

for (h in 1:length(nodes))
{
  tails <- which(suffix[h] == prefix)
  tails <- tails[tails != h] #prevents edge between suffix and prefix of the same sequence
  
  adj <<- rbind(adj, 
                cbind("heads" = nodes[rep(h, length(tails))] ,"tails" = nodes[tails])
  )
}

write.table(adj, file = "grph_solution.txt", quote = FALSE, sep =" ", row.names = FALSE, col.names = FALSE)



