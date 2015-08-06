README for pRSEM's demo
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
Prior-enhanced RSEM (pRSEM)

![alt text](https://github.com/pliu55/pRSEM_demo/blob/master/input/workflow.jpg)

## <a name="Software"></a> Software
- __pRSEM__: prior-enhanced RSEM 
- __STAR__: aligner for RNA-seq reads
- __Bowtie__: aligned for ChIP-seq reads

## <a name="Input"></a> Input
All of the following data sets are in folder 'input/'
- RNA-seq data set, paired-end reads in FASTQ format
  - mmliver_1.fa.gz
  - mmliver_2.fa.gz
- ChIP-seq
  - mmliver.narrowPeak.gz
  - mmliver.PolIIRep1.fq.gz
  - mmliver.PolIIRep2.fq.gz
  - mmliver.ctrl.fa.gz
- Genome sequence
  - chr19.fa
- Transcript annotation
  - chr19.gtf
- Mappability
  - mm10.36mer.chr19.fake.bigWig


## <a name="Usage"></a> Usage
- A simple approach: go to this demo's folder and type './run_pRSEM_demo.sh', it will do everything for you

or 

- A step-by-step approach
  1. Go to this demo's folder.
  2. Install all software packages: type 'make'. It will take about 15 minutes 
     to install everything on a 2.4G core. It may run faster than that if user
     had some R/Bioconductor libraries already installed.
  3. Prepare genomic reference: type './scr/01_prsem_prep_ref.py'. It will take 
     about 4 minutes on a 4x2.4GHz cores.
  4. Calculate expression: type './scr/02_prsem_calc_expr.py'. 

## <a name="Output"></a> Output
All output files are in folder 'output/'

Note that, in order to shorten the running time as much as possible, I prepared extremely small (and unrealistic) sizes of ChIP-seq and RNA-seq files, as well as a very quick Gibbs sampling process. As a result, the final outputs may have some variations.

## <a name="License"></a> License
This demo is licensed under the [GNU General Public License
v3](http://www.gnu.org/licenses/gpl-3.0.html).
