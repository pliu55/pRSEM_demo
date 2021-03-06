#!/bin/bash 

demodir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

inputdir="$demodir/input/"
starpath="$demodir/STAR/source/"
bowtiepath="$demodir/bowtie/"

outputdir="$demodir/output/"
refdir="$outputdir/genome_references/"
expr_polII_dir="$outputdir/quantification_results_PolII/"
expr_histone_dir="$outputdir/quantification_results_histone/"
test_histone_dir="$outputdir/testing_procedure_histone_PolII/"

runid='demo'
chrom='chr19'
nthr=4
sort_bam_buffer_size='1G'
partition_model_pk='pk'
nsteps=100

fgtf_gz="$inputdir/${chrom}.gtf.gz"
fgtf="$inputdir/${chrom}.gtf"
chrfa_gz="$inputdir/${chrom}.fa.gz"
chrfa="$inputdir/${chrom}.fa"
rnaseq_rd1="$inputdir/mmliver_1.fq.gz"
rnaseq_rd2="$inputdir/mmliver_2.fq.gz"
chipseq_control_rep1="$inputdir/ChIPseqCtrl.fq.gz"
chipseq_target_rep1="$inputdir/PolIIRep1.fq.gz"
chipseq_target_rep2="$inputdir/PolIIRep2.fq.gz"
polII_chipseq_peak="$inputdir/PolII.bed.gz"
fmpp_bigwig="$inputdir/mm10.36mer.chr19.fake.bigWig"

H3K27Ac_reads="$inputdir/H3K27Ac.fastq.gz"
H3K4me1_reads="$inputdir/H3K4me1.fastq.gz"
H3K4me2_reads="$inputdir/H3K4me2.fastq.gz"
H3K4me3_reads="$inputdir/H3K4me3.fastq.gz"



## install pRSEM, STAR, and bowtie
 make

## create $fgtf
if [ ! -f $fgtf ]
  then
    zcat $fgtf_gz > $fgtf
fi

## create $chrfa
if [ ! -f $chrfa ]
  then
    zcat $chrfa_gz > $chrfa
fi

## remove output/ if exists
 if [ -e $outputdir ] 
   then
     rm -fr $outputdir
 fi

## prepare reference
 mkdir -p $refdir
 $demodir/RSEM/rsem-prepare-reference \
  --gtf $fgtf \
  --star \
  --star-path $starpath \
  -p $nthr \
  --bowtie-path $bowtiepath \
  --prep-pRSEM \
  --mappability-bigwig-file $fmpp_bigwig \
  -q  \
  $chrfa $refdir/$runid
  

## calculate expression and run pRSEM using Pol II ChIP-seq
 mkdir -p $expr_polII_dir
 $demodir/RSEM/rsem-calculate-expression \
  --estimate-rspd \
  --seed 12345 \
  --num-threads $nthr \
  --paired-end \
  --forward-prob 0 \
  --keep-intermediate-files \
  --calc-pme \
  --gibbs-number-of-samples $nsteps \
  --no-bam-output \
  --quiet \
  --star \
  --star-path $starpath \
  --star-gzipped-read-file \
  --run-pRSEM \
  --partition-model $partition_model_pk \
  --chipseq-target-read-files $chipseq_target_rep1,$chipseq_target_rep2 \
  --chipseq-control-read-files $chipseq_control_rep1 \
  --bowtie-path $bowtiepath \
  $rnaseq_rd1 $rnaseq_rd2 $refdir/$runid $expr_polII_dir/$runid


## calculate expression and run pRSEM using four histone modification ChIP-seq
 mkdir -p $expr_histone_dir
 $demodir/RSEM/rsem-calculate-expression \
  --estimate-rspd \
  --seed 12345 \
  --num-threads $nthr \
  --paired-end \
  --forward-prob 0 \
  --keep-intermediate-files \
  --calc-pme \
  --gibbs-number-of-samples $nsteps \
  --no-bam-output \
  --quiet \
  --star \
  --star-path $starpath \
  --star-gzipped-read-file \
  --run-pRSEM \
  --chipseq-read-files-multi-targets $H3K27Ac_reads,$H3K4me1_reads,$H3K4me2_reads,$H3K4me3_reads \
  --bowtie-path $bowtiepath \
  $rnaseq_rd1 $rnaseq_rd2 $refdir/$runid $expr_histone_dir/$runid


if [ -e $test_histone_dir ] 
  then
    rm -fr $test_histone_dir
fi
cp -r $expr_histone_dir $test_histone_dir
## run a testing procedure using four histone modification ChIP-seq
 $demodir/RSEM/rsem-run-prsem-testing-procedure \
  --num-threads $nthr \
  --keep-intermediate-files \
  --quiet \
  --chipseq-read-files-multi-targets $H3K27Ac_reads,$H3K4me1_reads,$H3K4me2_reads,$H3K4me3_reads \
  --bowtie-path $bowtiepath \
  $refdir/$runid $test_histone_dir/$runid


## run a testing procedure using PolII ChIP-seq peak
 $demodir/RSEM/rsem-run-prsem-testing-procedure \
  --num-threads $nthr \
  --keep-intermediate-files \
  --quiet \
  --chipseq-peak-file $polII_chipseq_peak \
  $refdir/$runid $test_histone_dir/$runid
