#! /bin/bash

set -euf -o pipefail

eval $(opam config env) && \
opam install -y \
  depext \
  utop \
  sexplib \
  ppx_sexp_conv \
  ppx_deriving_protobuf \
  merlin
