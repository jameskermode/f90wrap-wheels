# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    curl https://codeload.github.com/jameskermode/f90wrap/tar.gz/v${F90WRAP_VERSION}.tar.gz -o f90wrap.tgz
    tar xzf f90wrap.tar.gz
    (cd f90wrap-${F90WRAP_VERSION}/examples; PYTHON=python make test)
}
