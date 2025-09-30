#!/bin/bash
export CUDA_VISIBLE_DEVICES=0
# random seed
seed=1211

# for dataset
DATASET_NAME="extra_p_133_class_v3"
DATASET_TYPE="protein"
# for task
TASK_TYPE="multi_class"
TASK_LEVEL_TYPE="seq_level"
LABEL_TYPE="extra_p_133_class"

# for input
## seq, vector, matrix, seq_matrix, seq_vector
### sequence + embedding channels
INPUT_TYPE="seq"
## single or pair
INPUT_MODE="single"
TRUNC_TYPE="right"

# for model
MODEL_TYPE="lucaprot"
CONFIG_NAME="lucaprot_config.json"
FUSION_TYPE="concat"
dropout_prob=0.1
fc_size=256
classifier_size=$fc_size
BEST_METRIC_TYPE="f1"
loss_type="cce"

## for sequence channel
SEQ_MAX_LENGTH=3432
hidden_size=1024
intermediate_size=4096
num_attention_heads=4
num_hidden_layers=2
### pooling type: none, max, mean, value_attention
SEQ_POOLING_TYPE="value_attention"
# word-level
codes_file="step_3_all_sequences_corpus_codes_30000.txt"
seq_subword="step_3_all_sequences_corpus_subword_vocab_30000.txt"

## for embedding channel
embedding_input_size=2560
matrix_max_length=3072
### pooling type: none, max, value_attention
MATRIX_POOLING_TYPE="value_attention"
### embedding llm
llm_version="esm2"
llm_type="esm"
llm_step="3B"

# for training
## max epochs
num_train_epochs=50
## accumulation gradient steps
gradient_accumulation_steps=4
# 间隔多少个step在log文件中写入信息（实际上是gradient_accumulation_steps与logging_steps的最小公倍数, 这里是4000）
logging_steps=1000
## checkpoint的间隔step数。-1表示按照epoch粒度保存checkpoint
save_steps=-1
## warmup_steps个step到达peak lr
warmup_steps=2000
## 最大迭代step次数(这么多次后，peak lr1变为lr2, 需要根据epoch,样本数量,n_gpu,batch_size,gradient_accumulation_steps进行估算）
## -1自动计算
max_steps=-1
## batch size for one GPU
batch_size=16
## 最大学习速率(peak learning rate)
learning_rate=2e-4
## data loading buffer size
buffer_size=4096
## tokenizer dir
tokenizer_dir=step_3
## positive weight
weight=13,212,7,8,21,31,3,10,4,27,28,3,363,589,6,2,20,1,4,37,32,179,17,30,14,110,1.2,4,12,11,64
weight=1
# weight=20,14,30,2,600,20,1,13,10,18,6,1,8,32,4,4,11,64,7,3,4,180,30,12,3,110,27,28,369,37,215
weight=1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,1/5,2/5,2/5,2/5,2/5,2/5,2/5,2/5,2/5,3/5,3/5,3/5,3/5,3/5,3/5,4/5,4/5,4/5,4/5,4/5,4/5,5/5,5/5,6/5,6/5,6/5,6/5,7/5,7/5,7/5,7/5,7/5,7/5,7/5,8/5,8/5,8/5,8/5,9/5,9/5,9/5,9/5,9/5,11/5,11/5,11/5,11/5,13/5,13/5,13/5,13/5,13/5,14/5,14/5,14/5,14/5,14/5,15/5,15/5,16/5,17/5,18/5,20/5,20/5,22/5,23/5,26/5,29/5,30/5,32/5,33/5,33/5,33/5,34/5,36/5,36/5,38/5,40/5,40/5,41/5,43/5,43/5,44/5,45/5,45/5,46/5,48/5,49/5,49/5,50/5,54/5,54/5,54/5,56/5,57/5,60/5,61/5,63/5,70/5,74/5,75/5,83/5,85/5,86/5,89/5,89/5,92/5,108/5,138/5,147/5,200/5,205/5,242/5,346/5,467/5,744/5,1004/5,3349/5,6698/5,1435/5

# model building time
time_str=$(date "+%Y%m%d%H%M%S")

cd ../..
python run_seq_only.py \
  --train_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/train/ \
  --dev_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/dev/ \
  --test_data_dir ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/test/ \
  --buffer_size $buffer_size \
  --dataset_name $DATASET_NAME \
  --dataset_type $DATASET_TYPE \
  --task_type $TASK_TYPE \
  --task_level_type $TASK_LEVEL_TYPE \
  --model_type $MODEL_TYPE \
  --input_type $INPUT_TYPE \
  --input_mode $INPUT_MODE \
  --label_type $LABEL_TYPE \
  --seq_subword \
  --codes_file ../subword/$tokenizer_dir/$codes_file \
  --label_filepath ../kinases_dataset/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/label.txt  \
  --output_dir ../models/step_3/shallow_100/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --log_dir ../logs/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --tb_log_dir ../tb-logs/$DATASET_NAME/$DATASET_TYPE/$TASK_TYPE/$MODEL_TYPE/$INPUT_TYPE/$time_str \
  --config_path ../config/$MODEL_TYPE/$CONFIG_NAME \
  --seq_vocab_path ../vocab/$tokenizer_dir/$seq_subword \
  --seq_pooling_type $SEQ_POOLING_TYPE \
  --matrix_pooling_type $MATRIX_POOLING_TYPE \
  --fusion_type $FUSION_TYPE \
  --do_train \
  --do_eval \
  --do_predict \
  --do_metrics \
  --evaluate_during_training \
  --per_gpu_train_batch_size=$batch_size \
  --per_gpu_eval_batch_size=$batch_size \
  --gradient_accumulation_steps=$gradient_accumulation_steps \
  --learning_rate=$learning_rate \
  --lr_update_strategy step \
  --lr_decay_rate 0.95 \
  --num_train_epochs=$num_train_epochs \
  --overwrite_output_dir \
  --seed $seed \
  --loss_type $loss_type \
  --best_metric_type $BEST_METRIC_TYPE \
  --seq_max_length=$SEQ_MAX_LENGTH \
  --embedding_input_size $embedding_input_size \
  --matrix_max_length=$matrix_max_length \
  --trunc_type=$TRUNC_TYPE \
  --weight $weight \
  --save_all \
  --llm_version $llm_version \
  --llm_type $llm_type \
  --llm_step $llm_step \
  --ignore_index -100 \
  --hidden_size $hidden_size \
  --intermediate_size $intermediate_size \
  --num_attention_heads $num_attention_heads \
  --num_hidden_layers $num_hidden_layers \
  --dropout_prob $dropout_prob \
  --classifier_size $classifier_size \
  --seq_fc_size $fc_size \
  --matrix_fc_size $fc_size \
  --vector_fc_size $fc_size \
  --emb_activate_func gelu \
  --fc_activate_func gelu \
  --classifier_activate_func gelu \
  --warmup_steps $warmup_steps \
  --beta1 0.9 \
  --beta2 0.99 \
  --weight_decay 0.01 \
  --save_steps $save_steps \
  --max_steps $max_steps \
  --logging_steps $logging_steps \
  --max_grad_norm 1.0 \
  --embedding_complete \
  --embedding_complete_seg_overlap \
  --matrix_embedding_exists \
  --matrix_add_special_token \
  --no_token_type_embeddings \
  --no_position_embeddings \
  --use_rotary_position_embeddings



