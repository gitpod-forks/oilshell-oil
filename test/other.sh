#!/usr/bin/env bash
#
# Usage:
#   ./other.sh <function name>

set -o nounset
set -o pipefail
set -o errexit

# Fails because of NoSingletonAction?
find-test() {
  pushd tools/find
  ./find-test.sh
  popd
}

xargs-test() {
  pushd tools/xargs
  ./xargs-test.sh
  popd
}

csv2html-test() {
  pushd web/table
  ./csv2html-test.sh all
  popd
}

# Fails
pgen2-test() {
  pgen2/pgen2-test.sh all
}

"$@"
