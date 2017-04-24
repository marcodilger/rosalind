# Consensus and Profile
# 
# Given: A collection of at most 10 DNA strings of equal length (at most 1 kbp) in FASTA format.
# 
# Return: A consensus string and profile matrix for the collection. (If several possible consensus strings exist, then you may return any one of them.)
# 
# Sample Dataset
# 
# >Rosalind_1
# ATCCAGCT
# >Rosalind_2
# GGGCAACT
# >Rosalind_3
# ATGGATCT
# >Rosalind_4
# AAGCAACC
# >Rosalind_5
# TTGGAACT
# >Rosalind_6
# ATGCCATT
# >Rosalind_7
# ATGGCACT
# 
# ATGCAACT
# A: 5 1 0 0 5 5 0 0
# C: 0 0 1 4 2 0 6 1
# G: 1 1 6 3 0 1 0 0
# T: 1 5 0 0 0 1 1 6

# read FASTA, keeps trailing ">" (but many packages are already available for this)

fragments <- strsplit(paste0(readLines("data/rosalind_cons.txt"), collapse=""), "\\>")[[1]]
fragments <- gsub("(\\_+\\d+)", "\\1~", fragments, perl=TRUE)
fasta <- strsplit(fragments,"~", perl=TRUE)
fasta.df <- data.frame(matrix(unlist(fasta), ncol=2, byrow=T), stringsAsFactors = FALSE)


# create consensus matrix, assuming all reads have the same length (per problem description)

sequences <- fasta.df[ ,2]
cons.matrix <- matrix( , nrow = 4, ncol = 0) #create empty matrix to be able to use cbind in the loop
rownames(cons.matrix) <- c("A","C","T","G")

repeat {
  cur.seq <- substr(sequences, 1,1)
 
  cons.matrix <- cbind(cons.matrix, as.matrix(mapply(function(x) sum(cur.seq == x), c("A","C","T","G"))))
  sequences <- substr(sequences, 2,nchar(sequences[1]))
  
  if (nchar(sequences[1]) == 0)
  {
    break
  }
}

cons.seq <- paste0(apply(cons.matrix, 2, function(x) rownames(cons.matrix)[which.max(x)]), collapse="")

# formatting output, took the longest time :( )
# 

writeLines(cons.seq, "cons_out.txt")
rownames(cons.matrix) <- c("A:","C:","T:","G:")
write.table(cons.matrix,"cons_out.txt",row.names=T,col.names=F,quote = F,append=T)

