#!/usr/bin/env bash

KEYS_SERVER=$2

echo "[RVM TASK] Installing RVM... please wait around 5 minutes or less."

# Import GPG keys
gpg --keyserver $KEYS_SERVER --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

# Sometimes the key server times out and RVM can't be installed without verifying keys.
# If that's the case, you can get the keys from the rvm.io website. 
# A bit more insecure since a webserver can be compromised with bad keys.
# Comment the gpg line above and uncomment the 2 lines below.
#curl -sSL https://rvm.io/mpapis.asc | gpg --import -
#curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

curl -sSL https://get.rvm.io | bash -s $1