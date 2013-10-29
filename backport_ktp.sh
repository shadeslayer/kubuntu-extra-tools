#!/bin/sh
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

for repo in $REPOS
do
    backportpackage --destination ${1} --upload "${2}" --yes ${repo}
done
