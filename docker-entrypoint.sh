#!/bin/sh
set -e

usage() {
    echo "Usage: command [options]"
    echo
    echo "where 'command' is one of:"
    echo "  - quickstart:"
    echo "  - sphinx-quickstart: Create a new documentation site (by default in /docs)"
    echo "    Execute 'sphinx-quickstart --help' for all command line options."
    echo
    echo "  - make: Build the sphinx documentation."
    echo "    Execute 'make help' for a list of targets."
    echo "    This options is only valid if a sphinx doc exists."
}

command="$1"
shift

case "$command" in

    quickstart|sphinx-quickstart)
    	sphinx-quickstart \
	    	--templatedir /etc/defaults/sphinx \
		    --makefile --use-make-mode --no-batchfile \
            $@
        ;;

    make)
        if [[ -e "Makefile" ]]
        then
            make $@
        else
            echo "Sphinx documentation not found."
            usage
        fi
        ;;
    *)
        usage
        exit 1
esac
