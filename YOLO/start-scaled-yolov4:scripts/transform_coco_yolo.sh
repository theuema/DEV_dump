# transform_coco_yolo.sh

#!/bin/bash

export COCO_DIR=~/datasets/coco2017
export OUTPUT_DIR=~/datasets/coco2017_yolov5

# train
python coco2yolov5.py \
    --coco_img_dir $COCO_DIR/train2017/ \
    --coco_ann_file $COCO_DIR/annotations/instances_train2017.json \
    --output_dir $OUTPUT_DIR

# val
python coco2yolov5.py \
    --coco_img_dir $COCO_DIR/val2017/ \
    --coco_ann_file $COCO_DIR/annotations/instances_val2017.json \
    --output_dir $OUTPUT_DIR \
    --obj_names_file $OUTPUT_DIR/train2017.names
