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
echo "Downloaded: bvlc_googlenet (Caffe)"

# this link will stop working on august 31, 2016
WORD2VEC_FILE="models/word2vec/GoogleNews-vectors-negative300.bin.gz"
WORD2VEC_URL="https://googledrive.com/host/0B7XkCwpI5KDYNlNUTTlSS21pQmM"
if [ ! -e $WORD2VEC_FILE ]; then
	echo "Downloading word2vec model..."
	curl -o $WORD2VEC_FILE -L $WORD2VEC_URL
fi
echo "Downloaded: word2vec model (gensim)"

INCEPTIONV3_URL="https://storage.googleapis.com/download.tensorflow.org/models/inception_dec_2015.zip"
INCEPTIONV3_FILE="models/inceptionv3/inception.zip"
INCEPTIONV3_DIR="models/inceptionv3/"
INCEPTIONV3_RESULT="models/inceptionv3/tensorflow_inception_graph.pb"
if [ ! -e $INCEPTIONV3_RESULT ]; then
	echo "Downloading Inception-v3 (for TensorFlow)..."
	curl -o $INCEPTIONV3_FILE $INCEPTIONV3_URL
	unzip $INCEPTIONV3_FILE -d $INCEPTIONV3_DIR
fi
echo "Downloaded: Inception-v3 (TensorFlow)"

NEWSGROUPS_URL="https://archive.org/download/20newsgroups.pkl/20newsgroups.pkl.gz"
NEWSGROUPS_FILE="data/20newsgroups.pkl.gz"
if [ ! -e $NEWSGROUPS_FILE ]; then
	echo "Downloading 20 Newsgroups dataset."
	curl -o $NEWSGROUPS_FILE $NEWSGROUPS_URL -L
fi
echo "Downloaded: 20 Newgroups dataset (sklearn)"

cd apple2373/chainer_caption_generation
bash download.sh &>/dev/null
bash download_jp.sh &>/dev/null
cd - &>/dev/null
echo "Downloaded: English and Japanese caption models (Chainer)."
