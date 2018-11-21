#! /bin/bash

set -euf -o pipefail

eval $(opam config env) && \
opam install -y \
  depext \
  travis-opam \
  merlin \
  astring \
  fpath \
  cmdliner \
  jbuilder \
  dune-release \
  topkg \
  topkg-care \
  topkg-jbuilder \
  xmlm \
  xtmpl \
  utop \
  sexplib \
  ppx_sexp_conv \
  ounit \
  bisect_ppx \
  async_ssl
