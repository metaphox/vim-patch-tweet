#/bin/bash

if [ ! -f twitter_oauth ]; then
    echo twitter_oauth file not found.
    exit 1
fi

if [ ! -f latest_patch ]; then
    echo latest_patch file not found.
    exit 1
fi

latest=$(curl -s ftp://ftp.vim.org/pub/vim/patches/7.4/README | tail -n 1)
versionNumber=$(echo $latest | cut -d ' ' -f 2)
patchText="#vim new patch: $(echo $latest | cut -d ' ' -f 2-)"

if [ "$(cat latest_patch)" != "$versionNumber" ] ; then
    twitter --oauth twitter_oauth set $patchText
    echo $versionNumber > latest_patch
    echo $patchText
fi
