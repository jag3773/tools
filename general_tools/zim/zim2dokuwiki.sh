#!/usr/bin/env sh
# -*- coding: utf8 -*-
#  Copyright (c) 2013 Jesse Griffin
#  http://creativecommons.org/licenses/MIT/
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

PROGNAME="${0##*/}"

help() {
    echo
    echo "Convert Zim files to DokuWiki files."
    echo
    echo "Usage:"
    echo "   $PROGNAME -s <zimsourcedir> -d <dokuwikidestinationdir>"
    echo "   $PROGNAME --help"
    echo
    exit 1
}

if [ $# -lt 1 ]; then
    help
fi
while test -n "$1"; do
    case "$1" in
        --help|-h)
            help
            ;;
        --source|-s)
            src=$2
            shift
            ;;
        --destination|-d)
            dst=$2
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            help
            ;;
    esac
    shift
done

# Verify we have a good path names
if [ ! -d "$src" -o ! -d "$dst" ]; then
    echo "Error: source and destination must be directories."
    help
fi

# Create DokuWiki files from Zim source files
for f in `ls "$src"`; do
    sed -e 's/..\/..\/..\/images\//:en:obs:/g' \
        -e 's/..\/..\/images\//:en:obs:/g' \
        -e '1,3d' \
        "$src/$f" > "$dst/$f"
done
