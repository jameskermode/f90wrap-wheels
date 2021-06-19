# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

source gfortran-install/gfortran_utils.sh

function pre_build {
    install_gfortran
    if [ "$PLAT" == "arm64" ] || [ "$PLAT" == "universal2" ]; then
        # ensure we use the cross-compiler for Fortran 90 as well F77
        export F90=/opt/gfortran-darwin-arm64/bin/arm64-apple-darwin20.0.0-gfortran
    fi
}

# override install_run from multibuild, since we need to access the tests from repo root
function install_run {
    if [ "$PLAT" == "arm64" ] || [ "$PLAT" == "universal2" ]; then
	export F90=/opt/gfortran-darwin-arm64/bin/arm64-apple-darwin20.0.0-gfortran
    fi    
    install_wheel
    cd f90wrap/examples
    make test
}

