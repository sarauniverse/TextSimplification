#!/bin/bash
source ./config.sh

if [ -z "$1" ]
  then
  	echo "Usage : predict.sh <model file path>"
    exit 1
fi
cd $OPENNMT_DIR
th translate.lua -model $1 -src ${LIVE_PRED_DIR}/data.txt -output ${LIVE_PRED_DIR}/pred.txt