#!/bin/sh

read -r -d '' ABOUT <<- INFO
# Simple LaTeX to PDF compile and cleanup script
#
# Created: 2021 by Vivien Richter <vivien-richter@outlook.de>
# License: CC-BY-4.0
# Version: 1.1.0

Usage: run.sh [-c] [FILE]

'FILE' means the filename without extension or path.

Options:
    -c                    Deletes all (REALLY ALL, except for *.pdf) generated LaTeX output files.
    -h, --help, -?        Shows this info text and terminates the script.
INFO

# Configuration
CLEANUP_EXTENSIONS=$(cat .gitignore | grep "^[^#]")

# Detects command line parameters.
if [ $# -gt 0 ]; then
    while [ "$1" != "" ]; do
		case $1 in
			-c )
				CLEANUP=true
				;;
			-h | --help | -? )
				echo "$ABOUT"
				exit 0
				;;
			* )
				NAME=$1
				;;
		esac
		shift
	done
else
    echo "$ABOUT"
	exit 1
fi

# Compilation
if [ -f "$NAME.tex" ]; then
    xelatex $NAME
    biber $NAME
    xelatex $NAME
    xelatex $NAME
else
    echo "LaTeX file not found or given, so nothing compiled."
fi

# Cleanup
if [ "$CLEANUP" = true ]; then
	rm -f $CLEANUP_EXTENSIONS
    echo "Everything clean."
fi
