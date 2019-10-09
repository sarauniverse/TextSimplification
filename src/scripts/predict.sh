#!/bin/bash
if [ -z "$1" ]
  then
  	echo "Usage : predict.sh <model file path>"
    exit 1
fi
MODEL_FILE=`greadlink -f $1`
cd scripts
source ./config.sh

cd $OPENNMT_DIR
th translate.lua -replace_unk -model ${MODEL_FILE} -src ${LIVE_PRED_DIR}/data.txt -output ${LIVE_PRED_DIR}/pred.txt