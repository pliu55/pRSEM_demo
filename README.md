README for pRSEM demo
================

Table of Contents
-----------------

* [Introduction](#Introduction)
* [Download](#Download)
* [System Requirements](#SystemRequirements)
* [Submodules](#Submodules)
* [Usage](#Usage)
* [Input](#Input)
* [Output](#Output)
* [Contact](#Contact)
* [License](#License)

* * *

## <a name="Introduction"></a> Introduction
Prior-enhanced RSEM (pRSEM) is an RNA-seq quantification method that utilizes external data for the task of transcript abundance estimation. The workflow of pRSEM is illustrated in the following figure.

![alt text](https://github.com/pliu55/pRSEM_demo/blob/master/input/workflow.jpg)

This repository is a mini-example for running pRSEM. It contains all the required software packages, input files, and scripts. More details is described below. This demo runs in 4 threads. The installation and running will take about 20 to 30 minutes on a 4 x 2.4GHz core machine depending on which R/Bioconductor libraries users have already installed.

## <a name="Download"></a> Download
There are two ways to download this demo and all three required submodules
- Download the [tar ball](https://github.com/pliu55/pRSEM_demo/releases/download/v0.2/pRSEM_demo_and_AllSubmodules.tar.gz) or [ zip file](https://github.com/pliu55/pRSEM_demo/releases/download/v0.2/pRSEM_demo_and_AllSubmodules.zip) via https. They are also listed on [the release page](https://github.com/pliu55/pRSEM_demo/releases) with name __pRSEM_demo_and_AllSubmodules__ 
- Use a git command: `git clone --recursive git@github.com:pliu55/pRSEM_demo`

## <a name="SystemRequirements"></a> System Requirements
- Linux
- Hard drive space > 2.5G
- Perl version >= 5.8.8
- Python version >= 2.7.3
- R version >= 3.3.1
- POSIX Threads
- Boost (C++ libraries)

## <a name="Submodules"></a> Submodules
This demo requires three submodules:
- [pRSEM](https://github.com/deweylab/RSEM): prior-enhanced RSEM
- [STAR](https://github.com/alexdobin/STAR/tree/2.5.2b): aligner for RNA-seq reads, version 2.5.2b
- [Bowtie](http://bowtie-bio.sourceforge.net/index.shtml): aligned for ChIP-seq reads, version 1.0.1

## <a name="Usage"></a> Usage
Go to this demo's folder and type 
```
./run_pRSEM_demo.sh
``` 
This script will carry out the following tasks:

1. Install Bowtie, STAR, RSEM, and all required libraries not yet installed by users
2. Prepare genome references for Bowtie, STAR, and RSEM
3. Derive prior parameters from RNA Polymerase II ChIP-seq data and use them to quantify RNA-seq data
4. Derive prior parameters from a combination of four histone modfication ChIP-seq data sets and use them to quantify RNA-seq data
5. Perform a testing procedure using a combination of four histone modification ChIP-seq data sets as the external data
6. Perform a testing procedure using RNA Polymerase II ChIP-seq peaks as the external data

## <a name="Input"></a> Input
All of the following data sets are under the folder __input/__. The RNA-seq and PolII ChIP-seq data were derived from [ENCODE2 mouse Mel cell line](https://www.encodeproject.org/biosamples/ENCBS049ENC/). Although they are derived from a cell line rather than from tissue, we named them with keyword __mmliver__ just to be consistent with the examples given in RSEM's documentation. The four histone modification ChIP-seq data sets were derived from [Lara-Astiaso and Weiner et al. *Science* 2014 345:943](http://science.sciencemag.org/content/345/6199/943.full). 
- RNA-seq, paired-end reads in FASTQ format, a small subset of [the RNA-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000CWE/) 
  - __mmliver_1.fa.gz__: first mate 
  - __mmliver_2.fa.gz__: second mate
- Pol II ChIP-seq reads in FASTQ format
  - __mmliver_PolIIRep1.fq.gz__: replicate 1 for RNA polymerase II, a small subset of [the Pol II ChIP-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000EUC/)
  - __mmliver_PolIIRep2.fq.gz__: replicate 2 for RNA polymerase II, a small subset of [the Pol II ChIP-seq data on Mel's biological replicate 2](https://www.encodeproject.org/experiments/ENCSR000EUC/)
  - __mmliver_ChIPseqCtrl.fa.gz__: replicate 1 for control, a small subset of the [the control ChIP-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000EUF/)
- Pol II ChIP-seq peaks in BED format
  - __PolII.bed.gz__: ChIP-seq peaks for RNA polymerase II. It was derived from the above FASTQ files using [ENCODE2's pipeline](https://sites.google.com/site/anshulkundaje/projects/idr) with an IDR threshold at 0.05. 
- Histone modification ChIP-seq in FASTQ format
  - __H3K27Ac.fastq.gz__: a small subset of [H3K27Ac modification ChIP-seq data from LT_HSC cells](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1441269) 
  - __H3K4me1.fastq.gz__: a small subset of [H3K4me1 modification ChIP-seq data from LT_HSC cells](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1441285)
  - __H3K4me2.fastq.gz__: a small subset of [H3K4me2 modification ChIP-seq data from LT_HSC cells](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1441301)
  - __H3K4me3.fastq.gz__: a small subset of [H3K4me3 modification ChIP-seq data from LT_HSC cells](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1441317)
- Genome sequence
  - __chr19.fa.gz__: gzipped Chromosome 19 sequence from mouse's mm10 assembly.
- Transcript annotation
  - __chr19.gtf.gz__: gzipped Protein-coding genes on chromsome 19 from [GENCODE mouse release M4](http://www.gencodegenes.org/mouse_releases/4.html)
- Mappability
  - __mm10.36mer.chr19.fake.bigWig__: a mocked alignability files for mm10's chromosome 19


## <a name="Output"></a> Output
All output files will be stored in the following four folders under __output/__:

- __genome_references/__: genomic index files for Bowtie, STAR, and RSEM

- __quantification_results_PolII/__: output files from pRSEM's expression-calculation step by using prior from Pol II ChIP-seq data. They are organized in the same way as [RSEM's output](http://deweylab.github.io/RSEM/rsem-calculate-expression.html#OUTPUT). The only difference is that there are five files specifically generated by pRSEM under folder __output/quantification_results_PolII/demo.stat/__:  
  * __demo_prsem.all_tr_features__: isofrom features to derive and assign pRSEM prior. The first line is a header and the rest is one isoform per line. The description for each column is:

    | column name | descrption |
    |:-----:|-----|
    | __trid__    | transcript ID from input annotation |
    | __geneid__  | gene ID from input anntation        |
    |__chrom__    | isoform's chromosome name |
    |__strand__   | isoform's strand name |
    |__start__    | TSS if isoform is on '+' strand; TES if isoform is on '-' strand; where TSS stands for isoform's transcription start site, i.e. 5'-end, and TES stands for isoform's transcript end site, i.e. 3'-end|
    |__end__      | TES if isoform is on '+' strand; TSS if isoform is on '-' strand |
    |__tss_mpp__  | average mappability of [TSS-500bp, TSS+500bp] |
    |__body_mpp__ | average mappability of (TSS+500bp, TES-500bp) |
    | __tes_mpp__ | average mappability of [TES-500bp, TES+500bp] |
    |__pme_count__| isoform's fragment or read count from RSEM's posterior mean estimates |
    |__tss__      | isoform's TSS |
    |__tss_pk__   | equal to 1 if isoform's [TSS-500bp, TSS+500bp] region overlaps with a RNA Pol II peak; 0 otherwise |
    |__is_training__| equal to 1 if isoform is in the training set where Pol II prior is learned; 0 otherwise |
    |__partition__| group number that isoform was partitioned to|
  
  * __demo_prsem.all_tr_prior__: prior parameters for every isoform. This file does not have a header. Each line contains an isoform's prior parameter and its transcript ID delimited by `  # `
  * __demo_prsem.pval_LL__: contains a p-value indicating if Pol II ChIP-seq data is informative for RNA-seq quantification and a log-likelihood denoting the fitness of pRSEM's Dirichlet-multinomial model to Pol II-partitioned training set isoforms
  * __demo_uniform_prior_1.gene.results__: RSEM's posterior mean estimates on the gene level with an initial pseudo-count of one for every isoform 
  * __demo_uniform_prior_1.isoform.results__: RSEM's posterior mean estimates on the isoform level with an initial pseudo-count of one for every isoform 

- __quantification_results_histone__/: output files from pRSEM's expression-calculation step by using prior from four histone modification ChIP-seq data. They are very similar to those in __quantification_results_PolII__/. The only difference are in two files:
  * __demo_prsem.all_tr_features__: similar to __quantification_results_PolII/demo.stat/demo_prsem.all_tr_features__. It does not have the column __tss_pk__, but a few more new columns as shown below: 

    |  column name |  description |
    |--------------|--------------|
    |__pme_TPM__   | isoform abundance from RSEM's posterior mean estimates|
    |__H3K27Ac__   | normalized H3K27Ac signals (in RPKM) of isoform's [TSS-500, TSS+500]|
    |__H3K4me1__   | normalized H3K4me1 signals (in RPKM) of isoform's [TSS-500, TSS+500]|
    |__H3K4me2__   | normalized H3K4me2 signals (in RPKM) of isoform's [TSS-500, TSS+500]|
    |__H3K4me3__   | normalized H3K4me3 signals (in RPKM) of isoform's [TSS-500, TSS+500]|
    |__prd_expr_prob__| probability of being expressed from a logistic regression model |
    |__prior__     | isoform's prior parameter|
    
  * __demo_prsem.lgt_mdl.RData__: It stores an R logistic regression object, which was obtained based on four histone modification signals and fragment counts of isoforms in the training set.

- __testing_procedure_histone_PolII/__: output files from pRSEM's testing procedure. Test results are saved in __demo.all.pval_LL__. All the other files are similar to those in __quantification_results_PolII__/ and __quantification_results_histone__/.
  * __demo.all.pval__LL__: contains three lines 
    - line 1: Header
    - line 2: Testing procedure result when using four histone modification ChIP-seq data as the external data for RNA-seq quantification
    - line 3: Testing procedure result when using Pol II peaks as the external data for RNA-seq quantification 

Please note that, in order to shorten the running time as much as possible, the input ChIP-seq and RNA-seq files were prepared in extremely small (and unrealistic) sizes, and Gibbs sampling were set to run in just 100 instead of the default 1000 steps. As a result, the final quantification results may vary from time to time.

## <a name="Contact"></a> Contact
Got a question? Please post it at [RSEM's GitHub Issues page](https://github.com/deweylab/RSEM/issues) with __@pliu55__ mentioned.  

## <a name="License"></a> License
This demo is licensed under the [GNU General Public License
v3](http://www.gnu.org/licenses/gpl-3.0.html).
