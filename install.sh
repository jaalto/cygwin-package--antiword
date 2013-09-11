#!/bin/bash
#
# install.sh -- Custom installation steps

INSTDIR=${1:-.inst}

make -f Makefile.cygwin global_install \
    DESTDIR=$INSTDIR  \
    GLOBAL_INSTALL_DIR="/usr/bin" \
    prefix=usr \
    exec_prefix=usr

# End of file
