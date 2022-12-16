# Import necessary libraries
import random
from Bio import SeqIO

# Define a function to mutate a gene sequence
def mutate_gene(gene_sequence):
  # Select a random point in the gene sequence to mutate
  mutate_point = random.randint(0, len(gene_sequence))
  
  # Generate a new random nucleotide to replace the one at the mutation point
  new_nucleotide = random.choice(["A", "C", "G", "T"])
  
  # Create a new mutated gene sequence by replacing the nucleotide at the mutation point
  mutated_gene = gene_sequence[:mutate_point] + new_nucleotide + gene_sequence[mutate_point + 1:]
  
  # Return the mutated gene sequence
  return mutated_gene

# Define a function to calculate the information content of a gene sequence
def calculate_information_content(gene_sequence):
  # Create a dictionary to store the frequency of each nucleotide in the gene sequence
  nucleotide_frequencies = {"A": 0, "C": 0, "G": 0, "T": 0}
  
  # Count the frequency of each nucleotide in the gene sequence
  for nucleotide in gene_sequence:
    nucleotide_frequencies[nucleotide] += 1
  
  # Calculate the information content of the gene
  information_content = 0
  for nucleotide, frequency in nucleotide_frequencies.items():
    # Calculate the probability of the nucleotide
    probability = frequency / len(gene_sequence)
    
    # Calculate the contribution of the nucleotide to the information content
    if probability > 0:
      information_content += -probability * math.log2(probability)
  
  # Return the information content of the gene
  return information_content

# Read a gene sequence from a FASTA file
gene_sequence = next(SeqIO.parse("my_gene.fasta", "fasta")).seq

# Mutate the gene sequence
mutated_gene = mutate_gene(gene_sequence)

#
