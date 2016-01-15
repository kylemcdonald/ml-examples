#!/usr/bin/env bash

echo "ml-examples: Checking for changes."
git pull origin master # check for updates to the code

echo "ml-examples: Initializing submodules."
git submodule init # registers submodules with git

echo "ml-examples: Pulling all submodules."
git submodule foreach git pull origin master # iterate through submodules and pull updates

BVLC_GOOGLENET_FILE="models/bvlc_googlenet/bvlc_googlenet.caffemodel"
BVLC_GOOGLENET_URL="http://dl.caffe.berkeleyvision.org/bvlc_googlenet.caffemodel"
BVLC_GOOGLENET_DEPLOY_FILE="models/bvlc_googlenet/deploy.prototxt"
BVLC_GOOGLENET_DEPLOY_URL="https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_googlenet/deploy.prototxt"
if [ ! -e $BVLC_GOOGLENET_FILE ]; then
	echo "Downloading bvlc_googlenet (Caffe)"
	curl -o $BVLC_GOOGLENET_DEPLOY_FILE $BVLC_GOOGLENET_DEPLOY_URL
	curl -o $BVLC_GOOGLENET_FILE $BVLC_GOOGLENET_URL	
fi
echo "Downloaded: bvlc_googlenet (Caffe)"

# this link will stop working on august 31, 2016
WORD2VEC_FILE="models/word2vec/GoogleNews-vectors-negative300.bin.gz"
WORD2VEC_URL="https://googledrive.com/host/0B7XkCwpI5KDYNlNUTTlSS21pQmM"
WORD2VEC_DIR="models/word2vec/"
mkdir -p WORD2VEC_DIR
if [ ! -e $WORD2VEC_FILE ]; then
	echo "Downloading word2vec model (gensim)"
	curl -o $WORD2VEC_FILE -L $WORD2VEC_URL
fi
echo "Downloaded: word2vec model (gensim)"

INCEPTIONV3_URL="https://storage.googleapis.com/download.tensorflow.org/models/inception_dec_2015.zip"
INCEPTIONV3_FILE="models/inceptionv3/inception.zip"
INCEPTIONV3_DIR="models/inceptionv3/"
INCEPTIONV3_RESULT="models/inceptionv3/tensorflow_inception_graph.pb"
mkdir -p $INCEPTIONV3_DIR
if [ ! -e $INCEPTIONV3_RESULT ]; then
	echo "Downloading Inception-v3 (TensorFlow)"
	curl -o $INCEPTIONV3_FILE $INCEPTIONV3_URL
	unzip $INCEPTIONV3_FILE -d $INCEPTIONV3_DIR
fi
echo "Downloaded: Inception-v3 (TensorFlow)"

NEWSGROUPS_URL="https://archive.org/download/20newsgroups.pkl/20newsgroups.pkl.gz"
NEWSGROUPS_FILE="data/20newsgroups.pkl.gz"
if [ ! -e $NEWSGROUPS_FILE ]; then
	echo "Downloading 20 Newsgroups dataset (sklearn)"
	curl -o $NEWSGROUPS_FILE $NEWSGROUPS_URL -L
fi
echo "Downloaded: 20 Newgroups dataset (sklearn)"

cd apple2373/chainer_caption_generation
bash download.sh &>/dev/null
bash download_jp.sh &>/dev/null
cd - &>/dev/null
echo "Downloaded: English and Japanese caption models (Chainer)"

NIN_URL="https://www.dropbox.com/s/0cidxafrb2wuwxw/nin_imagenet.caffemodel?dl=1"
NIN_FILE="models/nin/nin_imagenet.caffemodel"
NIN_DIR="models/nin/"
mkdir -p $NIN_DIR
if [ ! -e $NIN_FILE ]; then
	echo "Downloading Network In Network (for caffe)"
	curl -o $NIN_FILE -L $NIN_URL
fi
echo "Downloaded: Network In Network (Caffe)"

VGG16_URL="http://www.robots.ox.ac.uk/\~vgg/software/very_deep/caffe/VGG_ILSVRC_16_layers.caffemodel"
VGG16_FILE="models/vgg/VGG_ILSVRC_16_layers.caffemodel"
VGG16_DIR="models/vgg/"
mkdir -p $VGG16_DIR
if [ ! -e $VGG16_FILE ]; then
	echo "Downloading VGG_ILSVRC_16_layers (for caffe)"
	curl -o $VGG16_FILE $VGG16_URL
fi
echo "Downloaded: VGG 16 (Caffe)"

I2V_URL="http://illustration2vec.net/models/illust2vec_tag_ver200.caffemodel"
I2V_FILE="models/i2v/illust2vec_tag_ver200.caffemodel"
I2V_DIR="models/i2v/"
mkdir -p $I2V_DIR
if [ ! -e $I2V_FILE ]; then
	echo "Downloading Illustration2Vec (for caffe)"
	curl -o $I2V_FILE $I2V_URL
fi
echo "Downloaded: Illustration2Vec (Caffe)"
