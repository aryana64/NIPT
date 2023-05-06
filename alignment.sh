source activate environments  #processing the environment to work with
conda install bwa 
conda install -c bioconda samtools
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz #download the reference genome
scp -rp genedev2:/sf/storage/gmo/hic/out/_RawReads/2022-08-16_Novogene_data/X201SC22041027-Z01-F003/01.RawData/N32 /directory_on_the_local_machine #copy the samples from remote server to local machine  (ssh-agent is used) 
REF=/path_to_the_reference_genome
bwa index -p /prefix_of_the_output_database -a bwtsw $REF   #indexing the reference genome
bwa mem -t 20 /database_prefix /path_to_sample1.fq.gz /path_to_sample2.fq.gz | samtools sort -o /path_to_output.sorted.bam #alignment itself and sorting in a 'genome order'
