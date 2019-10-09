#!/bin/bash
SRC_DIR=`greadlink -f ..`
DATA_DIR=`greadlink -f ../../data`
OPENNMT_DIR=`greadlink -f ../../OpenNMT`
EMBED_DIR=${DATA_DIR}/embed
GLOBAL_EMBED=${EMBED_DIR}/GoogleNews-vectors-negative300.bin
EXP_NAME=NTS
