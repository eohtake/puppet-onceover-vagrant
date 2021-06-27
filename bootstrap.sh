#!/bin/bash

export CONTROL_REPO_URL="https://github.com/puppetlabs/control-repo.git"
export CONTROL_REPO_FOLDER="control-repo"
echo

echo "[TASK 1] Installing tools"
sudo apt-get install tree -y 2>/dev/null
sudo apt-get install mlocate -y 2>/dev/null
echo

echo "[TASK 2] Cloning a Puppet control repo"
if [ ! -d "$CONTROL_REPO" ]; then
    git clone $CONTROL_REPO_URL
fi
echo

echo "[TASK 3] Installing onceover"
cd $HOME/$CONTROL_REPO_FOLDER
bundle init
echo "gem \"onceover\"" >> Gemfile
bundle install
echo

echo "[TASK 4] Initializing onceover on the the control repo"
bundle exec onceover init
echo $(pwd)/$CONTROL_REPO
tree $CONTROL_REPO
echo

echo "[TASK 5] Running a first onceover test (It will fail!)"
bundler exec onceover run spec
echo
echo "To access the box and see the contents of $(pwd)/$CONTROL_REPO run: vagrant ssh"

