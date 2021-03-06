#!/bin/bash -e
# Copyright 2016 C.S.I.R. Meraka Institute
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# this should be run after check-build finishes.
. /etc/profile.d/modules.sh
echo ${SOFT_DIR}
module add deploy
echo ${SOFT_DIR}
cd ${WORKSPACE}/${NAME}-${VERSION}
echo "All tests have passed, will now build into ${SOFT_DIR}"
./configure --prefix ${SOFT_DIR} \
 --enable-shared \
 --enable-static
make install
echo "Creating the modules file directory ${LIBRARIES}"
mkdir -p ${LIBRARIES}/${NAME}
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
    puts stderr "       This module does nothing but alert the user"
    puts stderr "       that the [module-info name] module is not available"
}

module-whatis   "$NAME $VERSION : See https://github.com/SouthAfricaDigitalScience/gsl-deploy"
setenv GSL_VERSION $VERSION
setenv GSL_DIR     $::env(CVMFS_DIR)/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH $::env(GSL_DIR)/lib
prepend-path CPATH $::env(GSL_DIR)/include/
prepend-path PATH  $::env(GSL_DIR)/bin
MODULE_FILE
) > ${LIBRARIES}/${NAME}/${VERSION}

echo "Checking gsl program"
module add gsl/${VERSION}
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
