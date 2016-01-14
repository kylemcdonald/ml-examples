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
	echo "Downloading bvlc_googlenet (for Caffe)..."
	curl -o $BVLC_GOOGLENET_DEPLOY_FILE $BVLC_GOOGLENET_DEPLOY_URL
	curl -o $BVLC_GOOGLENET_FILE $BVLC_GOOGLENET_URL	
fi
echo "bvlc_googlenet is downloaded."

WORD2VEC_FILE="models/word2vec/GoogleNews-vectors-negative300.bin.gz"
WORD2VEC_URL="https://googledrive.com/host/0B7XkCwpI5KDYNlNUTTlSS21pQmM"
if [ ! -e $WORD2VEC_FILE ]; then
	echo "Downloading word2vec model..."
	curl -o $WORD2VEC_FILE -L $WORD2VEC_URL
fi
echo "word2vec model is downloaded."

INCEPTIONV3_URL="https://storage.googleapis.com/download.tensorflow.org/models/inception_dec_2015.zip"
INCEPTIONV3_FILE="models/inceptionv3/inception.zip"
INCEPTIONV3_DIR="models/inceptionv3/"
INCEPTIONV3_RESULT="models/inceptionv3/tensorflow_inception_graph.pb"
if [ ! -e $INCEPTIONV3_RESULT ]; then
	echo "Downloading Inception-v3 (for TensorFlow)..."
	curl -o $INCEPTIONV3_FILE $INCEPTIONV3_URL
	unzip $INCEPTIONV3_FILE -d $INCEPTIONV3_DIR
fi
echo "Inception-v3 is downloaded."