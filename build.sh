#!/bin/bash -e
SOURCE_FILE=$NAME-$VERSION.tar.gz
echo $SRC_DIR
module load ci
# SRC_DIR=/repo/src/$NAME
#module load gcc/4.8.2
echo "getting the file from gnu.org mirror"
if [[ ! -s $SRC_DIR/$SOURCE_FILE ]] ; then
  mkdir -vp $SRC_DIR
#wget --verbose ftp://ftp.is.co.za/mirror/ftp.gnu.org/gnu/gsl/$SOURCE_FILE -O $SRC_DIR/$SOURCE_FILE
  wget http://mirror.ufs.ac.za/gnu/gnu/$NAME/$NAME-$VERSION.tar.gz -O $SRC_DIR/$SOURCE_FILE
fi
ls -lht $SRC_DIR/$SOURCE_FILE
tar xfz $SRC_DIR/$SOURCE_FILE -C $WORKSPACE
cd $WORKSPACE/$NAME-$VERSION
./configure --prefix $SOFT_DIR
make -j 8
