#!/bin/bash
module load ci
make check
make install
make install DESTDIR=$WORKSPACE/build
mkdir -p $REPO_DIR
rm -rf $REPO_DIR/*
tar -cvzf $REPO_DIR/build.tar.gz -C $WORKSPACE/build apprepo
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
MODULE_FILE
) > modules/$VERSION
mkdir -p $LIBRARIES_MODULES/$NAME
cp modules/$VERSION $LIBRARIES_MODULES/$NAME
ls -lht /apprepo
ls -lht /apprepo/*