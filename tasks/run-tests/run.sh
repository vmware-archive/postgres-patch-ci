#!/usr/bin/env bash

set -xe

apt update
apt install sudo build-essential libreadline-dev zlib1g-dev bison flex -y

pushd postgres-repo-tarball
    tar xvf *.tgz

    pushd postgres-repo
        ./configure

        make install
        useradd postgres
        chown postgres:postgres -R .
        sudo su postgres bash -c "make check-world"
    popd
popd
