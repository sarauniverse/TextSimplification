#!/bin/bash
source ./config.sh
cd $OPENNMT_DIR
th train.lua -config ../configs/NTS.cfg