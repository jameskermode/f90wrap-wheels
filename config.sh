# Define custom utilities
# Test for macOS with [ -n "$IS_MACOS" ]

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    git clone https://github.com/jameskermode/f90wrap
    (cd f90wrap/examples; make test)
}