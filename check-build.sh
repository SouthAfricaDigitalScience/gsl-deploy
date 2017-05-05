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

. /etc/profile.d/modules.sh
module add ci
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
setenv GSL_DIR /data/ci-build/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH $::env(GSL_DIR)/lib
prepend-path CPATH $::env(GSL_DIR)/include/
prepend-path PATH  $::env(GSL_DIR)/bin
MODULE_FILE
) > modules/${VERSION}
mkdir -p ${LIBRARIES}/${NAME}
cp modules/${VERSION} ${LIBRARIES}/${NAME}

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
