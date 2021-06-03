# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

export F90WRAP_VERSION=0.2.6 # FIXME should avoid duplicating this from .travis.yml

source gfortran-install/gfortran_utils.sh

function pre_build {
    install_gfortran
}

function run_tests {
    # clone repo, checkout release branch and run tests
    if [[ ! -n "$IS_MACOS" ]]; then
        apt-get install -y git
        apt-get install -y gfortran
    fi
    git clone --depth 1 https://github.com/jameskermode/f90wrap
    cd f90wrap
    git checkout v${F90WRAP_VERSION}
    cd examples
    make test
}
