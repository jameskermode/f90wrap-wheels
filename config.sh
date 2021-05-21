# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pip download f90wrap==${F90WRAP_VERSION} --no-deps --no-binary :all:
    tar xzf f90wrap-${F90WRAP_VERSION}.tar.gz
    (cd f90wrap-${F90WRAP_VERSION}/examples; PYTHON=python make test)
}
