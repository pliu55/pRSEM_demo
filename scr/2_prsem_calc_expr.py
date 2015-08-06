#!/bin/env python

__doc__="""

  pliu 20150803

  prepare genomic reference for pRSEM

"""

import os
import time

class Param:
  scrdir = os.path.dirname(os.path.realpath(__file__)) + '/'
  inputdir    = scrdir + '../input/'
  starpath    = scrdir + '../STAR/source/'
  bowtiepath  = scrdir + '../bowtie/'
  calcexprbin = scrdir + '../RSEM/rsem-calculate-expression'
  preprefdir  = scrdir + '../output/1_prepref/'
  calcexprdir = scrdir + '../output/2_calcexpr/'

  runid = 'demo'
  chrom = 'chr19'
  rnaseq_rd1 = inputdir + 'mmliver_1.fq.gz'
  rnaseq_rd2 = inputdir + 'mmliver_2.fq.gz'
  chipseq_control_rep1 = inputdir + 'mmliver_ChIPseqCtrl.fq.gz'
  chipseq_target_rep1  = inputdir + 'mmliver_PolIIRep1.fq.gz'
  chipseq_target_rep2  = inputdir + 'mmliver_PolIIRep2.fq.gz'
  fmpp_bigwig          = inputdir + 'mm10.36mer.chr19.fake.bigWig'
  partition_model      = 'pk'
  sort_bam_buffer_size = '1G'
  nthr  = 4

  nsteps = 100

  def __init__(self):
    pass


def main():
  prm = Param()

  if not os.path.exists(prm.calcexprdir):
    os.makedirs(prm.calcexprdir)

  cmd = prm.calcexprbin + \
          ' --estimate-rspd ' + \
          ' --seed 12345 ' + \
          " --num-threads %d " % prm.nthr + \
          ' --paired-end ' + \
          ' --forward-prob 0 ' + \
          ' --keep-intermediate-files ' + \
          ' --calc-pme ' + \
          " --gibbs-number-of-samples %d " % prm.nsteps + \
          ' --quiet ' + \
          ' --star ' + \
          " --star-path %s " % prm.starpath + \
          ' --gzipped-read-file ' + \
          ' --sort-bam-by-read-name ' + \
          " --sort-bam-buffer-size %s " % prm.sort_bam_buffer_size + \
          ' --run-pRSEM ' + \
          " --partition-model %s " % prm.partition_model + \
          " --mappability-bigwig-file %s " % prm.fmpp_bigwig + \
          " --chipseq-target-read-files %s,%s " % (prm.chipseq_target_rep1,
                                                   prm.chipseq_target_rep2) + \
          " --chipseq-control-read-files %s " % prm.chipseq_control_rep1 + \
          " --bowtie-path %s " % prm.bowtiepath + \
          " %s %s %s/%s %s/%s " % (prm.rnaseq_rd1, prm.rnaseq_rd2,
                                   prm.preprefdir, prm.runid,
                                   prm.calcexprdir, prm.runid)

  print cmd;
  os.system(cmd)


if __name__=='__main__':
  start_t = time.time()
  main()
  print "time used for calculating expression: %d s" % (time.time() - start_t);
