#!/bin/bash -e
. /etc/profile.d/modules.sh
module load ci
cd ${NAME}-${VERSION}
make check
make install
mkdir -p modules
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
puts stderr " This module does nothing but alert the user"
puts stderr " that the [module-info name] module is not available"
}
module-whatis "$NAME $VERSION."
setenv GSL_VERSION $VERSION
setenv GSL_DIR /apprepo/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH $::env(GSL_DIR)/lib
prepend-path CPATH $::env(GSL_DIR)/include/
MODULE_FILE
) > modules/${VERSION}
mkdir -p ${LIBRARIES_MODULES}/${NAME}
cp modules/${VERSION} ${LIBRARIES_MODULES}/${NAME}

echo "Checking gsl program"
module add gsl
module list
echo ${CPATH}
ls -lht ${CPATH}/gsl
cd ${WORKSPACE}
echo "compiling"
g++ -c -L${GSL_DIR}/lib -lgsl -lgslcblas -lm hello-world.cpp
echo "linking"
g++ hello-world.o -L$GSL_DIR/lib -lgsl -lgslcblas
echo "executing"
./a.out
