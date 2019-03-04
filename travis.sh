#!/bin/bash

set -euo pipefail

function installTravisTools {
  mkdir -p ~/.local
  curl -sSL https://github.com/SonarSource/travis-utils/tarball/v54 | tar zx --strip-components 1 -C ~/.local
  source ~/.local/bin/install
}

installTravisTools
. installJDK8

. set_maven_build_version $TRAVIS_BUILD_NUMBER

export MAVEN_OPTS="-Xmx1536m -Xms128m"
mvn deploy \
    -Pdeploy-sonarsource,release \
    -B -e -V
