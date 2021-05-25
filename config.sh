# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

export F90FLAGS=-fPIC # ensure Fortran sources are compiled by numpy setuptools as position independent code

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    f90wrap --help
    f2py-f90wrap -h
}
