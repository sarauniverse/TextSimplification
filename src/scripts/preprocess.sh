#!/bin/bash
source ./config.sh
mkdir -p ${DATA_DIR}/preprocessed
cd $OPENNMT_DIR
th preprocess.lua -train_src ${DATA_DIR}/train_src.en -train_tgt ${DATA_DIR}/train_tgt.sen -valid_src ${DATA_DIR}/valid_src.en -valid_tgt ${DATA_DIR}/valid_tgt.sen -save_data ${DATA_DIR}/preprocessed/${EXP_NAME} -src_seq_length 80 -tgt_seq_length 80  -shuffle 1 -log_file ${DATA_DIR}/preprocessed/preprocess.log -src_vocab_size 50000 -tgt_vocab_size 50000 -log_level DEBUG