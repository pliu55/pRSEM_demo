BOWTIE = bowtie/to_make.flag
STAR = STAR/source/to_make.flag
RSEM = RSEM/to_make.flag

.PHONY : all clean

all : ${BOWTIE} ${STAR} ${RSEM}

${BOWTIE} : 
	cd ${@D}; ${MAKE} all

${STAR} : 
	cd ${@D}; ${MAKE} all

${RSEM} : 
	cd ${@D}; ${MAKE} all; ${MAKE} pRSEM

clean : 
	cd bowtie ;      ${MAKE} clean
	cd RSEM ;        ${MAKE} clean
	cd STAR/source ; ${MAKE} clean
