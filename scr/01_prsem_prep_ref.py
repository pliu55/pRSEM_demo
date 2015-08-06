#!/bin/env python

__doc__="""

  pliu 20150803

  prepare genomic reference for pRSEM

"""

import os
import time

class Param:
  scrdir = os.path.dirname(os.path.realpath(__file__)) + '/'
  inputdir   = scrdir + '../input/'
  starpath   = scrdir + '../STAR/source/'
  bowtiepath = scrdir + '../bowtie/'
  preprefbin = scrdir + '../RSEM/rsem-prepare-reference'
  outputdir  = scrdir + '../output/prepref/'

  runid = 'demo'
  chrom = 'chr19'
  fgtf  = inputdir + chrom + '.gtf'
  chrfa = inputdir + chrom + '.fa'
  nthr  = 4

  def __init__(self):
    pass


def main():
  prm = Param()

  if not os.path.exists(prm.outputdir):
    os.makedirs(prm.outputdir)

  cmd = prm.preprefbin + \
          ' --gtf ' + prm.fgtf + \
          ' --star ' + \
          ' --star-path ' + prm.starpath + \
          ' -p ' + str(prm.nthr) + \
          ' --bowtie-path ' + prm.bowtiepath + \
          ' --index-genome ' + \
          ' -q ' + \
          prm.chrfa +  ' ' + prm.outputdir + '/' + prm.runid

  print cmd;
  os.system(cmd)


if __name__=='__main__':
  start_t = time.time()
  main()
  print "time used for preparing reference: %d s" % (time.time() - start_t);
