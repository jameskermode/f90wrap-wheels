#!/bin/bash

export F90WRAP_VERSION=0.2.6
export PROJECT_SPEC="f90wrap==${F90WRAP_VERSION}"
export PLAT=universal2
export MB_PYTHON_VERSION=3.9

export BUILD_DEPENDS=oldest-supported-numpy
export TEST_DEPENDS=numpy

source multibuild/common_utils.sh
source multibuild/travis_osx_steps.sh
before_install
build_index_wheel $PROJECT_SPEC
install_run $PLAT
