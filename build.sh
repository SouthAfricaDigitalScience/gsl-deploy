#!/bin/bash -e
. /etc/profile.d/modules.sh
SOURCE_FILE=${NAME}-${VERSION}.tar.gz
echo ${SRC_DIR}
module load ci
# SRC_DIR=/repo/src/$NAME
module add gcc/4.8.4

# GSL can use FFTW and ATLAS
module add atlas
module add fftw/3.3.4
echo "getting the file from gnu.org mirror"
if [[ ! -s ${SRC_DIR}/${SOURCE_FILE} ]] ; then
  mkdir -vp ${SRC_DIR}
#wget --verbose ftp://ftp.is.co.za/mirror/ftp.gnu.org/gnu/gsl/$SOURCE_FILE -O $SRC_DIR/$SOURCE_FILE
  wget http://mirror.ufs.ac.za/gnu/gnu/${NAME}/${NAME}-${VERSION}.tar.gz -O ${SRC_DIR}/${SOURCE_FILE}
fi
ls -lht ${SRC_DIR}/${SOURCE_FILE}
ctar xfz ${SRC_DIR}/${SOURCE_FILE} -C ${WORKSPACE}
cd ${WORKSPACE}/${NAME}-${VERSION}
./configure --prefix ${SOFT_DIR}
make
