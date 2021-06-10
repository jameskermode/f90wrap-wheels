# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

export F90WRAP_VERSION=0.2.6 # FIXME should avoid duplicating this from .travis.yml

source gfortran-install/gfortran_utils.sh

function pre_build {
    install_gfortran
    if [ "$PLAT" == "arm64" ] || [ "$PLAT" == "universal2" ]; then
        # ensure we use the cross-compiler for Fortran 90 as well F77
        export F90=/opt/gfortran-darwin-arm64/bin/arm64-apple-darwin20.0.0-gfortran
    fi
}

function run_tests {
    # clone repo, checkout release branch and run tests
    if [[ ! -n "$IS_MACOS" ]]; then
        apt-get install -y git
        apt-get install -y gfortran
    fi
    git clone --depth 1 --branch v${F90WRAP_VERSION} https://github.com/jameskermode/f90wrap
    cd f90wrap
    cd examples
    make test
}
