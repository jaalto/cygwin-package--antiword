#!/bin/bash
#
# install.sh -- Custom installation steps
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ ./install.sh .inst/
#
# Below there are two methonds to chooce from:
#
# 1. Caxll original "make install" + doing the cleanup
#    This is function InstallUsingMake()
# 2. Doing it all manually. This is function Install()
#
#
# -- THIS AN EXAMPLE: MODIFY AS NEEDED    --
# -- DELETE FUNCTIONS THAT YOU DO NOT NEED --

DefineVariables()
{
    #  Load library function pefixed with "Cygbuild"

    if [ -z "$CYGBUILD_ID" ]; then
        #   Not yet loaded, so load now
        export CYGBUILD_LIB="activate as library"
        source $(/bin/which cygbuild.sh) || return 1
    fi

    #   This defines many varibales that can be used

    CygbuildLibInstallEnvironment $*
}

InstallInclude()
{
    #   -- THIS IS ONLY NEEDED IF                      --
    #   -- other packages provide same include.h files --
    #
    #   1. If there are clashing header files, they are at this point
    #      installed as package_include.sh
    #      The headers can be renamed at postinstall.sh step where each
    #      package_include.sh is symlinked to include.sh
    #
    #   2. If this is normal library which provides NEW headers, leave out
    #      '${packgae_' and the files will be installd normally

    local file

    for file in *.h
    do
         $INSTALL -D $INSTALL_BIN $file $includedir/${package}_${file}
    done
}

InstallMake()
{
    make=Makefile.Cygwin

    make -f $make global_install                    \
             DESTDIR=$(cd ${DESTDIR:-$instdir}; pwd) \
	     GLOBAL_INSTALL_DIR="/usr/bin" \
             prefix=${prefix:-usr}              \
             exec_prefix=${prefix:-usr}

}

InstallUsingMake()
{

    #   This is install option (2) - using package's make(1) and then fix
    #   what's left there. Uncomment as needed:

    DefineVariables $* &&
    InstallMake
}

InstallUsingMake $*

# End of file
