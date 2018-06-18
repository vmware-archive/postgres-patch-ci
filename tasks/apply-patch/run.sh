#!/usr/bin/env bash

set -e

dir=$PWD

apt update
apt install git -y

pushd postgres-repo > /dev/null
  oldSHA=$(git rev-parse HEAD)

  git \
    apply \
    ${dir}/patches/attachments/*

  git add -A

  git \
    -c user.name=postgres-bot \
    -c user.email=postgres-bot@pivotal.io \
    commit \
    -m 'Applied patch from CI'

  code_quotes='```'

  body=$(< ${dir}/patches/body)

  cat > metadata.txt <<EOF
*$(< ${dir}/patches/from) - $(< ${dir}/patches/subject)*
$(echo ${body} | cut -c 1-150 )...
${code_quotes}
$(git diff ..${oldSHA} --stat)
${code_quotes}
$(cd ${dir}/patches/attachments && ls )
EOF

  cat metadata.txt
popd > /dev/null

tar -czf artifacts/postgres-repo.tgz postgres-repo
