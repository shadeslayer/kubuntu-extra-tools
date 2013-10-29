#!/bin/bash
REPOS="
ktp-common-internals
ktp-accounts-kcm
ktp-approver
ktp-auth-handler
ktp-call-ui
ktp-contact-list
ktp-contact-runner
ktp-desktop-applets
ktp-filetransfer-handler
ktp-kded-integration-module
ktp-send-file
ktp-text-ui"

cur_dir=$PWD

for repo in $REPOS
do
    mkdir $repo
    cd $repo
    pull-lp-source $repo
    cd $repo-$1
#    sed -i 's/stable/unstable/' debian/watch
    uscan --verbose
    uupdate ../${repo}_${2}.orig.tar.bz2
    cd ../$repo-$2
    sed -i "s,libktpcommoninternalsprivate-dev (>= $1),libktpcommoninternalsprivate-dev (>= $2)," debian/control
    dch --release --distribution $3 ""
    debuild -S -sa
    cd $cur_dir
done
