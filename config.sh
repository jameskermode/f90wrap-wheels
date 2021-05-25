# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

function run_rests{
    F90WRAP_VERSION=$1

    # clone repo, checkout release branch and run tests
    apt-get install -y git
    git clone --depth 1 https://github.com/jameskermode/f90wrap
    cd f90wrap
    git checkout v${F90WRAP_VERSION}
    cd examples
    python3 run_all.py -v

}

function install_run{
    PLAT=$1
    F90WRAP_VERSION=$2

    install_wheel
    mkdir tmp_for_test
    (cd tmp_for_test && run_tests ${F90WRAP_VERSION})
    rmdir tmp_for_test  2>/dev/null || echo "Cannot remove tmp_for_test"
}