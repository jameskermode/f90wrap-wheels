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
        # ensure we use the cross-compiler for Fortran 90 as well as F77
        export F90=/opt/gfortran-darwin-arm64/bin/arm64-apple-darwin20.0.0-gfortran
    fi
}

# customize setup of cross compiler to remove -Wl,-rpath options that stop delocate from working correctly
function macos_arm64_cross_build_setup {
    echo Running custom macos_arm64_cross_build_setup
    # Setup cross build for single arch arm_64 wheels
    export PLAT="arm64"
    export BUILD_PREFIX=/opt/arm64-builds
    sudo mkdir -p $BUILD_PREFIX/lib $BUILD_PREFIX/include
    sudo chown -R $USER $BUILD_PREFIX
    update_env_for_build_prefix
    export _PYTHON_HOST_PLATFORM="macosx-11.0-arm64"
    export CFLAGS+=" -arch arm64"
    export CXXFLAGS+=" -arch arm64"
    export CPPFLAGS+=" -arch arm64"
    export ARCHFLAGS+=" -arch arm64"
    export FCFLAGS+=" -arch arm64"
    export FC=$FC_ARM64
    export MACOSX_DEPLOYMENT_TARGET="11.0"
    export CROSS_COMPILING=1
    local libgfortran="$(find /opt/gfortran-darwin-arm64/lib -name libgfortran.dylib)"
    local libdir=$(dirname $libgfortran)
    export FC_ARM64_LDFLAGS="-L$libdir"
    export LDFLAGS+=" -arch arm64 -L$BUILD_PREFIX/lib $FC_ARM64_LDFLAGS"
    # This would automatically let autoconf know that we are cross compiling for arm64 darwin
    export host_alias="aarch64-apple-darwin20.0.0"
}

# override install_run from multibuild, since we need to access the tests from repo root
function install_run {
#     if [ "$PLAT" == "arm64" ]; then
#     	echo Skipping test for cross-compiled wheel $PLAT
# 	return
#     fi    
    install_wheel
    if [ -z "$IS_MACOS" ]; then
        apt-get install -y gfortran
    fi
    cd f90wrap/examples
    make test
}

