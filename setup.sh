#!/usr/bin/env bash

echo "Checking for changes to ml-examples."
git pull origin master # check for updates to the code

echo "Initializing submodules."
git submodule init # registers submodules with git

echo "Updating submodules."
git submodule update # pulls content of submodule repos