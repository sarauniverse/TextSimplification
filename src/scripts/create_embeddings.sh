#!/bin/bash
source ./config.sh
mkdir -p ${EMBED_DIR}
echo "${DATA_DIR}/${EXP_NAME}.src.dict"
if [ ! -f ${GLOBAL_EMBED} ]; then
    echo "${GLOBAL_EMBED} does not exist. Run the ./download_global_embeddings.sh first"
    exit 1
fi

cd ${DATA_DIR} && cat *.en > ${EMBED_DIR}/corpus.en && cat *.sen > ${EMBED_DIR}/corpus.sen && cd ${SRC_DIR}
python train_word2vec.py ${EMBED_DIR}/corpus.en 200 && python train_word2vec.py ${EMBED_DIR}/corpus.sen 200 && cd $OPENNMT_DIR && th tools/concat_embedding.lua -dict_file ${DATA_DIR}/preprocessed/${EXP_NAME}.src.dict -global_embed ${GLOBAL_EMBED} -local_embed ${EMBED_DIR}/corpus.sen.bin -save_data ${EMBED_DIR}/sen-embeddings-${EXP_NAME} && th tools/concat_embedding.lua -dict_file ${DATA_DIR}/preprocessed/${EXP_NAME}.tgt.dict -global_embed ${GLOBAL_EMBED} -local_embed ${EMBED_DIR}/corpus.en.bin -save_data ${EMBED_DIR}/en-embeddings-${EXP_NAME}