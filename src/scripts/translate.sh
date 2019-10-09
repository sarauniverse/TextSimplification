#!/bin/bash
source ./config.sh

MODEL_PATH=`greadlink -f ../../models/nts_epoch14_8.47.t7`
MODEL=${MODEL_PATH##*/}
RES_DIR=`greadlink -f ../../results_${EXP_NAME}/${MODEL}`
mkdir -p $RES_DIR

BEAM_SIZE=5
GPUS=0
OUTPUT=${RES_DIR}/result_${MODEL}_${BEAM_SIZE}
LOG_OUT=${RES_DIR}/result_${MODEL}_${BEAM_SIZE}.log

SRC=${DATA_DIR}/test_src.en
TGT=${DATA_DIR}/test_tgt.sen
cd $OPENNMT_DIR 
th translate.lua -replace_unk -beam_size ${BEAM_SIZE} -gpuid ${GPUS} -n_best 4 -model ${MODEL_PATH} -src ${SRC} -tgt ${TGT} -output ${OUTPUT} -log_file ${LOG_OUT}
echo "Check results in "${OUTPUT}
