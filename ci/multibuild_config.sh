# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    if [ -z "$IS_OSX" ]; then
      if [ `uname -m` = "aarch64" ]; then
         yum update -y && yum install -y epel-release && yum clean all;
         yum install -y jsoncpp cmake3 openssl-devel;
         ln -sf /usr/bin/cmake3 /usr/bin/cmake;
      else
         pip install cmake;
      fi
    fi
}

function run_tests {
    # The function is called from an empty temporary directory.
    cd ../tests
    python -c "import freetype; print('Using FreeType version ', freetype.version())"
    pytest
}
