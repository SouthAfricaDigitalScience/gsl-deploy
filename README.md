[![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=gsl-deploy)](https://ci.sagrid.ac.za/job/gsl-deploy/)

# gsl-deploy

Build, test and deploy scripts necessary to deploy [GNU Science Libraries](https://www.gnu.org/software/gsl/), for CODE-RADE

# Dependencies

This project does not have any dependencies.


# Versions

We build the following versions for Foundation Release 3:

  * 1.16
  * 2.0
  * 2.1
  * 2.3

# Configuration

The  builds are configured with :

```
./configure --prefix ${SOFT_DIR} \
--enable-shared \
--enable-static

```


#  Citing

Cite as

Bruce Becker. (2017). SouthAfricaDigitalScience/gsl-deploy: CODE-RADE Foundation Release 3 : GSL [Data set]. Zenodo. http://doi.org/10.5281/zenodo.254292 [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.254292.svg)](https://doi.org/10.5281/zenodo.254292)
