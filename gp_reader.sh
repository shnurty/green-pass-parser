#!/bin/bash

declare -r _infile="(input file)"

declare -r _gp_b45_data=`mktemp`
declare -r _outfile="(output file)"

## -----------------------------

function check_dep
{
  which $1 2>/dev/null
  [ $? -ne 0 ] && echo "[missing dependency] '$1'" && exit 1
}

## -----------------------------

check_dep 'base45'

## -----------------------------

cat $_infile |cut -b5- |tr -d '\n' |base45 --decode >$_gp_b45_data
python -c "import zlib; print(zlib.decompress(open('$_gp_b45_data', 'rb').read()))" |sed 's;^b"\(.*\)"$;\1;' >$_outfile

