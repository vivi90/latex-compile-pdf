#!/bin/sh
#
# Simple LaTeX to PDF compile script
#
# Created: 2021 by Vivien Richter <vivien-richter@outlook.de>
# License: CC-BY-4.0
# Version: 1.0.0

NAME=$1
if [ -f "$NAME.tex" ]; then
    xelatex $NAME
    biber $NAME
    xelatex $NAME
    xelatex $NAME
else
    echo "LaTeX file not found."
fi
