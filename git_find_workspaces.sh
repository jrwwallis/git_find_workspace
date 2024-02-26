#!/bin/bash

# detect if "-executable" test is supported by this `find`
if find / -maxdepth 0 -executable >/dev/null 2>&1 ; then
    # Probably GNU find
    dirAccessible="-executable"
else
    # Probably BSD find
    dirAccessible="-perm -g+x"
fi

# assume current directory, if none specified
if [ "$1" = "" ]; then
    wd=.
else
    wd="$1"
fi

# find predicates:
#   don't traverse into other filesystems
#   skip anything not a directory
#   skip any non-accessible directory
#   skip ..dotfiles, but allow ..
#   skip .dotfiles, but allow ..
#   git workspace found! print, then don't traverse deeper; continue
#   git worktree found! print, then don't traverse deeper; continue

find "${wd}" \
    -mount \
    ! -type d -prune \
    -o ! ${dirAccessible} -prune \
    -o -name '..?*' -prune \
    -o -name '.[^.]*' -prune \
    -o -execdir test -f '{}/.git/HEAD' \; -print -prune \
    -o -execdir test -f '{}/.git' \; -print -prune \
