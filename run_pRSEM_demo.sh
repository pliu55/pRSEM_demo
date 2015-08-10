#!/bin/bash 

demodir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

inputdir="$demodir/input/"
starpath="$demodir/STAR/source/"
bowtiepath="$demodir/bowtie/"

outputdir="$demodir/output/"
refdir="$outputdir/1_prepref/"
expdir="$outputdir/2_calcexpr/"

runid='demo'
chrom='chr19'
nthr=4
sort_bam_buffer_size='1G'
partition_model='pk'
nsteps=100

fgtf="$inputdir/${chrom}.gtf"
chrfa="$inputdir/${chrom}.fa"
rnaseq_rd1="$inputdir/mmliver_1.fq.gz"
rnaseq_rd2="$inputdir/mmliver_2.fq.gz"
chipseq_control_rep1="$inputdir/mmliver_ChIPseqCtrl.fq.gz"
chipseq_target_rep1="$inputdir/mmliver_PolIIRep1.fq.gz"
chipseq_target_rep2="$inputdir/mmliver_PolIIRep2.fq.gz"
fmpp_bigwig="$inputdir/mm10.36mer.chr19.fake.bigWig"


## remove output/ if exists
if [ -e $outputdir ] 
  then
    rm -fr $outputdir
fi


## install pRSEM, STAR, and bowtie
make


## prepare reference
mkdir -p $refdir
$demodir/RSEM/rsem-prepare-reference \
  --gtf $fgtf \
  --star \
  --star-path $starpath \
  -p $nthr \
  --bowtie-path $bowtiepath \
  --index-genome \
  -q  \
  $chrfa $refdir/$runid
  

## calculate expression
mkdir -p $expdir
$demodir/RSEM/rsem-calculate-expression \
  --estimate-rspd \
  --seed 12345 \
  --num-threads $nthr \
  --paired-end \
  --forward-prob 0 \
  --keep-intermediate-files \
  --calc-pme \
  --gibbs-number-of-samples $nsteps \
  --quiet \
  --star \
  --star-path $starpath \
  --gzipped-read-file \
  --sort-bam-by-read-name \
  --sort-bam-buffer-size $sort_bam_buffer_size \
  --run-pRSEM \
  --partition-model $partition_model \
  --mappability-bigwig-file $fmpp_bigwig \
  --chipseq-target-read-files $chipseq_target_rep1,$chipseq_target_rep2 \
  --chipseq-control-read-files $chipseq_control_rep1 \
  --bowtie-path $bowtiepath \
  $rnaseq_rd1 $rnaseq_rd2 $refdir/$runid $expdir/$runid
