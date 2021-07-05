# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

source gfortran-install/gfortran_utils.sh

function install_delocate {
    check_pip
    $PIP_CMD install git+https://github.com/isuruf/delocate.git@arm64
}

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
    	echo Skipping test for cross-compiled wheel $PLAT
	return
    fi    
    install_wheel
    if [[ ! -n "IS_MACOS" ]]; then
        yum install -y gfortran
    fi
    cd f90wrap/examples
    make test
}

