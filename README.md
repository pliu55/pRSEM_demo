README for pRSEM demo
================

Table of Contents
-----------------

* [Introduction](#Introduction)
* [Software](#Software)
* [Input](#Input)
* [Usage](#Usage)
* [Output](#Output)
* [License](#License)

* * *

## <a name="Introduction"></a> Introduction
Prior-enhanced RSEM (pRSEM) is an RNA-seq quantification method that utilizes external data set for the task of transcript abundance estimation. Its workflow is shown in the following figure.

![alt text](https://github.com/pliu55/pRSEM_demo/blob/master/input/workflow.jpg)

This repository is a mini-example for running pRSEM. It contains all the required software packages, input files, installation and running scripts. Each component is described below in details.

## <a name="Software"></a> Software
- __pRSEM__: prior-enhanced RSEM 
- __STAR__: aligner for RNA-seq reads
- __Bowtie__: aligned for ChIP-seq reads

## <a name="Input"></a> Input
All of the following data sets are in the folder __input/__
- RNA-seq data set, paired-end reads in FASTQ format
  - __mmliver_1.fa.gz__: first read mate 
  - __mmliver_2.fa.gz__: second read mate
- ChIP-seq in FASTQ format
  - __mmliver_PolIIRep1.fq.gz__: replicate one for RNA polymerase II 
  - __mmliver_PolIIRep2.fq.gz__: replicate two for RNA polymerase II
  - __mmliver_ChIPseqCtrl.fa.gz__: replicate one of control
- Genome sequence
  - __chr19.fa__: Chromosome 19 of mouse's mm10 assembly. It is automatically downloaded from UCSC's FTP during installation of this demo. 
- Transcript annotation
  - __chr19.gtf__: Protein-coding genes from GENCODE mouse annotation version 4
- Mappability
  - __mm10.36mer.chr19.fake.bigWig__: a mocked alignability files for mm10's chromosome 19.


## <a name="Usage"></a> Usage
- A simple approach: go to this demo's folder and type __./run_pRSEM_demo.sh__, it will do everything for you

or 

- A step-by-step approach
  1. Go to this demo's folder.
  2. Type __make__ to install all software packages. It will take about 15 minutes to install everything on a 2.4G core machine. It may run faster if user had some R/Bioconductor libraries pre-installed.
  3. Type __./scr/1_prsem_prep_ref.py__ to prepare genomic reference. It will take about 3 minutes to finish on a 4 x 2.4GHz machine.
  4. Type __./scr/2_prsem_calc_expr.py__ to calculate expression. It will take about 5 minutes to finish on 4 x 2.4GHz machine.

## <a name="Output"></a> Output
All output files are in folder __output/__ created by the demo's script. 

- __output/1_prepref/__ contains all genomic index files for pRSEM, STAR, and bowtie
- __output/2_calcexpr/__ contains all output files from pRSEM's calculating expression step

Note that, in order to shorten the running time as much as possible, I prepared extremely small (and unrealistic) sizes of ChIP-seq and RNA-seq files, as well as a very quick Gibbs sampling process. As a result, the final outputs may have some variations.

## <a name="License"></a> License
This demo is licensed under the [GNU General Public License
v3](http://www.gnu.org/licenses/gpl-3.0.html).
