#! /bin/bash

set -euf -o pipefail

OPAMREPO=git/github.com/ocaml/opam-repository
# we disable opam sandboxing to allow docker setup
cd ~ && opam init --disable-sandboxing -a -y ~/$OPAMREPO --comp 4.13.1
