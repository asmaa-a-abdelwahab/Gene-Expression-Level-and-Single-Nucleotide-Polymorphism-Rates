#!/bin/sh

for i in high_max low_max high_median low_median high_breadth low_breadth; 
do
     grep -P "\texon\t" GRCh37_filtered_${i}.gtf | bedtools sort > output/exons_${i}.gtf
     bedtools sort -i output/exons_${i}.gtf > output/sorted_exons_${i}.gtf
     bedtools merge -s -i output/sorted_exons_${i}.gtf -c 6,7 -o distinct,distinct > output/exons_${i}.bed

     grep -P "\ttranscript\t" GRCh37_filtered_${i}.gtf | bedtools sort > output/transcripts_${i}.gtf
     bedtools sort -i output/transcripts_${i}.gtf > output/sorted_transcripts_${i}.gtf
     bedtools merge -s -i output/transcripts_${i}.gtf -c 6,7 -o distinct,distinct > output/transcripts_${i}.bed

     bedtools subtract -a output/transcripts_${i}.bed -b output/exons_${i}.bed > output/introns_${i}.bed

done
