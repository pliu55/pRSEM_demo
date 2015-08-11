README for pRSEM demo
================

Table of Contents
-----------------

* [Introduction](#Introduction)
* [Download](#Download)
* [System Requirements](#System Requirements)
* [Submodules](#Submodules)
* [Input](#Input)
* [Usage](#Usage)
* [Output](#Output)
* [Contact](#Contact)
* [License](#License)

* * *

## <a name="Introduction"></a> Introduction
Prior-enhanced RSEM (pRSEM) is an RNA-seq quantification method that utilizes external data set for the task of transcript abundance estimation. The workflow of pRSEM is depicted in the following figure.

![alt text](https://github.com/pliu55/pRSEM_demo/blob/master/input/workflow.jpg)

This repository is a mini-example for running pRSEM. It contains all the required software packages, input files, installation and running scripts. Each component is described below in details. This demo runs in 4 threads by default. The installation and running will take about 20 to 30 minutes on a 4 x 2.4GHz core machine depending on the R/Bioconductor libraries that the user has already installed.

## <a name="Download"></a> Download
There are two ways to download this demo and all three submodules
- Download the [tar ball](https://github.com/pliu55/pRSEM_demo/releases/download/v0.1/pRSEM_demo_and_AllSubmodules.tar.gz) or [ gzip file](https://github.com/pliu55/pRSEM_demo/releases/download/v0.1/pRSEM_demo_and_AllSubmodules.zip) via https from [the release page](https://github.com/pliu55/pRSEM_demo/releases). 
- Use git command `git clone --recursive git@github.com:pliu55/pRSEM_demo`

## <a name="System Requirements"></a> System Requirements
- Python >= 2.7.3
- R >= 3.1.2
- Hard drive space: > 2G

## <a name="Submodules"></a> Submodules
This demo requires three submodules:
- [pRSEM](https://github.com/pliu55/RSEM/tree/pRSEM): prior-enhanced RSEM 
- [STAR](https://github.com/alexdobin/STAR): aligner for RNA-seq reads, in version 2.4.0h
- [Bowtie](http://bowtie-bio.sourceforge.net/index.shtml): aligned for ChIP-seq reads, in version 1.0.1

## <a name="Input"></a> Input
All of the following data sets are under the folder __input/__. The RNA-seq and ChIP-seq data were derived from [ENCODE2 mouse Mel cell line](https://www.encodeproject.org/biosamples/ENCBS049ENC/). Although they are derived from a cell line rather than from tissue, we named them with keyword 'mmliver' just to be consistent with the examples given in pRSEM's documentation.    
- RNA-seq, paired-end reads in FASTQ format, a small subset of [the RNA-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000CWE/) 
  - __mmliver_1.fa.gz__: first mate 
  - __mmliver_2.fa.gz__: second mate
- ChIP-seq in FASTQ format
  - __mmliver_PolIIRep1.fq.gz__: replicate one for RNA polymerase II, a small subset of [the Pol II ChIP-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000EUC/)
  - __mmliver_PolIIRep2.fq.gz__: replicate two for RNA polymerase II, a small subset of [the Pol II ChIP-seq data on Mel's biological replicate 2](https://www.encodeproject.org/experiments/ENCSR000EUC/)
  - __mmliver_ChIPseqCtrl.fa.gz__: replicate one for control, a small subset of the [the control ChIP-seq data on Mel's biological replicate 1](https://www.encodeproject.org/experiments/ENCSR000EUF/)
- Genome sequence
  - __chr19.fa__: Chromosome 19 of mouse's mm10 assembly. It will be automatically downloaded from UCSC's FTP during the installation of this demo. 
- Transcript annotation
  - __chr19.gtf__: Protein-coding genes on chromsome 19 from [GENCODE mouse release M4](http://www.gencodegenes.org/mouse_releases/4.html)
- Mappability
  - __mm10.36mer.chr19.fake.bigWig__: a mocked alignability files for mm10's chromosome 19.


## <a name="Usage"></a> Usage
Go to this demo's fold and type `./run_pRSEM_demo.sh`. This script will install all required packages and run this demo.


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
