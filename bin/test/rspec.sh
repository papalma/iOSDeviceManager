#!/usr/bin/env bash

source bin/simctl.sh
source bin/log.sh

set -e


info "Use the DEVICE env variable to run specific rspec tests"
info "written for physical devices and test against connected one:"
info ""
info "DEVICE=1 make rspec"
info ""
info "By default, tests will be running against iOS simulator."

bundle update

tmpfile=$(mktemp)
Products/iOSDeviceManager >/dev/null 2>"${tmpfile}"
if [ -s "${tmpfile}" ]; then
  error "Expected iOSDeviceManager to output nothing on stderr"
  error "Output captured here: ${tmpfile}"
  exit 1
else
  info "iOSDeviceManager did not have unusual output"
  rm -f "${tmpfile}"
fi

banner "Rspec tests"

DEBUG=1 exec bundle exec rspec spec/launch_simulator_spec.rb
