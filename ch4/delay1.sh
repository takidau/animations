#!/bin/bash
NAME=$(basename "$0" | sed -e 's/[.]sh$//')
set -x
convert -density 350 "${NAME}.pdf[0]" "${NAME}.png"





