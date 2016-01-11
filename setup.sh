#!/usr/bin/env bash

echo "Checking for changes to ml-examples."
git pull origin master # check for updates to the code

echo "Initializing submodules."
git submodule init # registers submodules with git

echo "Updating submodules."
git submodule update # pulls content of submodule repos

BVLC_GOOGLENET_FILE="models/bvlc_googlenet/bvlc_googlenet.caffemodel"
BVLC_GOOGLENET_URL="http://dl.caffe.berkeleyvision.org/bvlc_googlenet.caffemodel"
BVLC_GOOGLENET_DEPLOY_FILE="models/bvlc_googlenet/deploy.prototxt"
BVLC_GOOGLENET_DEPLOY_URL="https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_googlenet/deploy.prototxt"
if [ ! -e $BVLC_GOOGLENET_FILE ]; then
	echo "Downloading bvlc_googlenet..."
	curl -o $BVLC_GOOGLENET_DEPLOY_FILE $BVLC_GOOGLENET_DEPLOY_URL
	curl -o $BVLC_GOOGLENET_FILE $BVLC_GOOGLENET_URL
fi