#!/bin/bash
source ./config.sh
mkdir -p $EMBED_DIR
cd $EMBED_DIR
wget https://s3.amazonaws.com/dl4j-distribution/GoogleNews-vectors-negative300.bin.gz && gunzip GoogleNews-vectors-negative300.bin.gz
