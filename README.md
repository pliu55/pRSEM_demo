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

## <a name="Software"></a> Software
- RSEM 
- STAR
- Bowtie

## <a name="Input"></a> Input
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

## <a name="Output"></a> Output

Note that, in order to shorten the running time as much as possible, I prepared extremely small (and unrealistic) sizes of ChIP-seq and RNA-seq files, as well as a very quick Gibbs sampling process. As a result, the final outputs may have some variations.

## <a name="License"></a> License
This demo is licensed under the [GNU General Public License
v3](http://www.gnu.org/licenses/gpl-3.0.html).
