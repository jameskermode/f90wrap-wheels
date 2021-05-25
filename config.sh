# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

export F90WRAP_VERSION=0.2.5 # FIXME should avoid duplicating this from .travis.yml

function run_rests {
    # clone repo, checkout release branch and run tests
    apt-get install -y git
    git clone --depth 1 https://github.com/jameskermode/f90wrap
    cd f90wrap
    git checkout v${F90WRAP_VERSION}
    cd examples
    python3 run_all.py -v
}