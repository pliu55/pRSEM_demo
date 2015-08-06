DATA = data/chr19.fa
BOWTIE = bowtie/to_make.flag
STAR = STAR/source/to_make.flag
RSEM = RSEM/to_make.flag

.PHONY : all clean

all : ${BOWTIE} ${DATA} ${STAR} ${RSEM}

${DATA} :
	if [ ! -e $@ ]; then cd ${@D} ; \
	wget -nc ftp://hgdownload.soe.ucsc.edu/goldenPath/mm10/chromosomes/$(@F).gz; \
	gzip -d $(@F).gz; \
	chmod -w $(@F); \
	fi

${BOWTIE} : 
	cd ${@D}; ${MAKE} all

${STAR} : 
	cd ${@D}; ${MAKE} all

${RSEM} : 
	cd ${@D}; ${MAKE} all

clean : 
	cd bowtie ;      ${MAKE} clean
	cd RSEM ;        ${MAKE} clean
	cd STAR/source ; ${MAKE} clean