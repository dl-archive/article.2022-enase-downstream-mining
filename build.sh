#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original (pdfTeX 1.40.23 = TeX Live 2021).
# Requires podman (or docker: export ENGINE=docker). Output: build/paper.pdf
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2021-historic
mkdir -p build
# scratch copy: epstopdf writes orcid-eps-converted-to.pdf next to orcid.eps
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" "$IMAGE" \
  sh -c 'cp -r /src /tmp/src && cd /tmp/src && latexmk -pdf -interaction=nonstopmode -outdir=/out paper.tex'
