README for pRSEM demo
================

Table of Contents
-----------------

* [Introduction](#Introduction)
* [Software](#Software)
* [Input](#Input)
* [Usage](#Usage)
* [Output](#Output)
* [Contact](#Contact)
* [License](#License)

* * *

## <a name="Introduction"></a> Introduction
Prior-enhanced RSEM (pRSEM) is an RNA-seq quantification method that utilizes external data set for the task of transcript abundance estimation. The workflow of pRSEM is depicted in the following figure.

![alt text](https://github.com/pliu55/pRSEM_demo/blob/master/input/workflow.jpg)

This repository is a mini-example for running pRSEM. It contains all the required software packages, input files, installation and running scripts. Each component is described below in details. This demo requires at least 2G hard drive space and it runs in 4 threads by default.

Since this repository contains three submodules, please use command __git clone --recursive git://github.com/pliu55/pRSEM_demo__ to download this demo.

## <a name="Software"></a> Software
- __pRSEM__: prior-enhanced RSEM 
- __STAR__: aligner for RNA-seq reads, in version 2.4.0h
- __Bowtie__: aligned for ChIP-seq reads, in version 1.0.1

## <a name="Input"></a> Input
All of the following data sets are in the folder __input/__
- RNA-seq, paired-end reads in FASTQ format
  - __mmliver_1.fa.gz__: first mate 
  - __mmliver_2.fa.gz__: second mate
- ChIP-seq in FASTQ format
  - __mmliver_PolIIRep1.fq.gz__: replicate one for RNA polymerase II 
  - __mmliver_PolIIRep2.fq.gz__: replicate two for RNA polymerase II
  - __mmliver_ChIPseqCtrl.fa.gz__: replicate one for control
- Genome sequence
  - __chr19.fa__: Chromosome 19 of mouse's mm10 assembly. It will be automatically downloaded from UCSC's FTP during the installation of this demo. 
- Transcript annotation
  - __chr19.gtf__: Protein-coding genes from GENCODE's mouse annotation version 4
- Mappability
  - __mm10.36mer.chr19.fake.bigWig__: a mocked alignability files for mm10's chromosome 19.


## <a name="Usage"></a> Usage
- A simple approach: type __./run_pRSEM_demo.sh__ under this demo's folder, it will install and run this demo.

or 

- A step-by-step approach
  1. Go to this demo's folder.
  2. Type __make__ to install all software packages. It will take about 15 minutes to install everything on a 2.4G core machine. It may run faster if the user had some pRSEM-dependent R/Bioconductor libraries installed.
  3. Type __./scr/1_prsem_prep_ref.py__ to prepare genomic references. It will take about 3 minutes to finish on a 4 x 2.4GHz machine.
  4. Type __./scr/2_prsem_calc_expr.py__ to quantify RNA-seq data using RNA polymearse II ChIP-seq data. It will take about 5 minutes to finish on 4 x 2.4GHz machine.

## <a name="Output"></a> Output
All output files are in folder __output/__ created by this demo's scripts. 

- __1_prepref/__ contains all output genomic index files for pRSEM, STAR, and bowtie
- __2_calcexpr/__ contains all output files from pRSEM's calculating expression step

Note that, in order to shorten the running time as much as possible, I prepared extremely small (and unrealistic) sizes of ChIP-seq and RNA-seq files, as well as a very quick Gibbs sampling process. As a result, the final outputs may have variations.

## <a name="Contact"></a> Contact
Got a question? Please post it at [RSEM Users group](https://groups.google.com/forum/#!forum/rsem-users) with keyword __pRSEM__ in the title.  

## <a name="License"></a> License
This demo is licensed under the [GNU General Public License
v3](http://www.gnu.org/licenses/gpl-3.0.html).
