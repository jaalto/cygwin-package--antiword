#!/bin/sh
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst
#
# This script is run after [install] command.

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}

    if [ "$root"  ] && [ -d $root ]; then

        root=$(echo $root | sed 's,/$,,')  # Delete trailing slash
	doc=$root/usr/share/doc/anti*/
	
	#  Remove unneeded files
	rm -f $doc/{QandA,Netscape} $doc/*.php

	# install manuals
	man=$root/usr/share/man/man1 	
	install -d -m 644 $man
	install -m 644 Docs/*.1 $man

    fi
}

Main "$@"

# End of file
