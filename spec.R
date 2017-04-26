# Inferring Protein from Spectrum
# 
# The prefix spectrum of a weighted string is the collection of all its prefix weights.
# 
# Given: A list LL of nn (n≤100n≤100) positive real numbers.
# 
# Return: A protein string of length n−1n−1 whose prefix spectrum is equal to LL (if multiple solutions exist, you may output any one of them). Consult the monoisotopic mass table.
# 
# Sample Dataset
# 
# 3524.8542
# 3710.9335
# 3841.974
# 3970.0326
# 4057.0646
# 
# Sample Output
# 
# WMQS
# 
# 

mass_table <- read.table("data/monoisotopic_mass_table.txt", stringsAsFactors = FALSE)
mass_table[ ,2] <- round(as.numeric(mass_table[ ,2]), 4)

data <- as.numeric(readLines("data/rosalind_spec.txt"))
mass <- data[-1] - data[-length(data)]

peptide <- mass_table[match(round(mass,4), round(mass_table[ ,2],4)) ,1]

writeClipboard(paste0(peptide, collapse=""))
