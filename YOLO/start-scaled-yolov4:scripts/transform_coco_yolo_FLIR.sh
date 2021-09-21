# transform_coco_yolo.sh

#!/bin/bash

export COCO_DIR=/ML/Dataset/FLIR_ADAS_1_3_coco2yolov5_fstructure
export OUTPUT_DIR=/ML/Dataset/Flir_ADAS_1_3_yolo

# train
python coco2yolov5_FLIR.py \
    --coco_img_dir $COCO_DIR/train/annotated_train_thermal_8_bit/ \
    --coco_ann_file $COCO_DIR/train/thermal_annotations.json \
    --output_dir $OUTPUT_DIR

# val
python coco2yolov5_FLIR.py \
    --coco_img_dir $COCO_DIR/val/annotated_val_thermal_8_bit/ \
    --coco_ann_file $COCO_DIR/val/thermal_annotations.json \
    --output_dir $OUTPUT_DIR \
    --obj_names_file $OUTPUT_DIR/val.names
