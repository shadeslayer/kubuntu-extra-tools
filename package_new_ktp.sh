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

old_release=$1
new_release=$2
cur_dir=$PWD

echo "Old release is : " $1
echo "\n"
echo "New release is : " $2
echo "\n"

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
    dch --release --distribution trusty ""
    debuild -S -sa
    cd $cur_dir
done
