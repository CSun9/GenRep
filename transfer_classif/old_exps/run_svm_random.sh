#!/bin/bash
CUDA_VISIBLE_DEVICES=$1 python extract_features.py --dataset voc2007 --data_folder /data/vision/torralba/datasets/PASCAL2007/ --model_weight scratch --expname $3
NAMEEXP=$3
OUT_PATH="../../scratch/svm_models/.${NAMEEXP}"
OUT_FEATS="../../scratch/features/data_voc2007_${NAMEEXP}"
echo $OUT_FEATS
python train_svm_kfold.py --data_file $OUT_FEATS --output_path $OUT_PATH --costs_list "0.0000001,0.000001,0.00001,0.0001,0.001,0.01,0.1,1.0,10.0,100.0"
python test_svm.py --data_file $OUT_FEATS --output_path $OUT_PATH --costs_list "0.0000001,0.000001,0.00001,0.0001,0.001,0.01,0.1,1.0,10.0,100.0"
