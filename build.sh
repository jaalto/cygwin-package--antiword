#!/bin/sh
#
# build.sh -- Custom build steps
#
# Parameters send to this script
#
#       build.sh <PACKAGE> <VERSION> <RELEASE>
#
# You could e.g. Pass correct make(1) flags in order to compile the package.
# or use different targest than the standard 'all'.

DIR=CYGWIN-PATCHES
EXT=.base64

Decode ()
{
    # Unpack all icons
	
    for src in $DIR/*$EXT
    do
      file=$(echo $src | sed "s/$EXT//")
      to=../$(basename $file)
      
      if [ ! -f $to ]; then
          base64 -d $src > $to || return 1
      fi
    done
}

Main ()
{ 
    Decode || { echo "$DIR/*.ico missing"; exit 1; }
    make -f Makefile.cygwin
}

Main "$@"

# End of file
