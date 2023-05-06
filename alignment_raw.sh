#!/bin/bash
#SBATCH --mem 40GB
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --output=/beegfs/data/hpcws/ws1/anudarieva-exocmar/scripts/logs/%x-%j-%N.out 
source activate environments  #processing the environment to work with
scp -rp genedev2:/sf/storage/gmo/hic/out/_RawReads/2022-08-16_Novogene_data/X201SC22041027-Z01-F003/01.RawData/N32 /home/aryana64 #copy the samples from remote server to local machine  (ssh-agent is used) 
conda install bwa 
conda install -c bioconda samtools
REF=/beegfs/data/hpcws/ws1/anudarieva-exocmar/hg38/hg38.fa
bwa index -p/beegfs/data/hpcws/ws1/anudarieva-exocmar/scripts/projects/ref_index -a bwtsw $REF   #indexing the reference genome
bwa mem -t 20 /beegfs/data/hpcws/ws1/anudarieva-exocmar/scripts/projects/ref_index /beegfs/data/hpcws/ws1/anudarieva-exocmar/N32/N32_FKDL220180557-1A_HJCT5DSX3_L1_1.fq.gz /beegfs/data/hpcws/ws1/anudarieva-exocmar/N32/N32_FKDL220180557-1A_HJCT5DSX3_L1_2.fq.gz | samtools sort -o /beegfs/data/hpcws/ws1/anudarieva-exocmar/scripts/projects/output.sorted.bam 
#alignment itself and sorting in a 'genome order'
