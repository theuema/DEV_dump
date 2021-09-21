# coco2yolo_scaledYolov4_example_FLIR

To use the scripts from YOLO/start-scaled-yolov4:scripts, change the FLIR Dataset folder structure from 

```
> find  -maxdepth 3 -type d
.
./val
    ./val/Annotated_thermal_8_bit
    ./val/RGB
    ./val/thermal_8_bit
    ./val/thermal_16_bit
./train
    ./train/Annotated_thermal_8_bit
    ./train/RGB
    ./train/thermal_8_bit
    ./train/thermal_16_bit
./video
    ./video/Annotated_thermal_8_bit
    ./video/thermal_8_bit
    ./video/thermal_16_bit
    ./video/rgb
```

to

```
> find  -maxdepth 3 -type d
.
./val
    ./val/annotated_val_thermal_8_bit
    ./val/RGB
    ./val/thermal_8_bit
    ./val/thermal_16_bit
./train
    ./train/annotated_train_thermal_8_bit
    ./train/RGB
    ./train/thermal_8_bit
    ./train/thermal_16_bit
./video
    ./video/Annotated_thermal_8_bit
    ./video/thermal_8_bit
    ./video/thermal_16_bit
    ./video/rgb
```

Use coco2yolov5_FLIR.py and transform_coco_yolo_FLIR.sh!
x 
Results in the following file structure: 
```
.
./annotated_train_thermal_8_bit.txt.ignored
./labels
    ./labels/annotated_train_thermal_8_bit
        FLIR_00001.txt
        .
        .
    ./labels/annotated_val_thermal_8_bit
        FLIR_00222.txt
        .
        .
./annotated_val_thermal_8_bit.names
./annotated_train_thermal_8_bit.names
./annotated_val_thermal_8_bit.txt
./images
    ./images/annotated_train_thermal_8_bit -> original folder with images
    ./images/annotated_val_thermal_8_bit -> original folder with images
./annotated_val_thermal_8_bit.txt.ignored
./annotated_train_thermal_8_bit.txt
```

Then, to update or create a yaml file for Scaled Yolo with the correct class names use:

```
python -c " 
names = open('annotated_train_thermal_8_bit.names', 'r').read().split('\n')
print(names)
"
```

*[Train](https://github.com/WongKinYiu/ScaledYOLOv4/tree/yolov4-large)*  

Example:
```
python -m torch.distributed.launch --nproc_per_node 4 train.py --batch-size 64 --img 640 512 --data flir.yaml --cfg yolov4-p6.yaml --weights weights/yolov4-p6_transfer.pt --sync-bn --device 0,1,2,3 --name yolov4-p6_flir
```
```
python train.py --batch-size 64 --img 640 512 --data flir.yaml --cfg yolov4-p6.yaml --weights weights/yolov4-p6_transfer.pt --sync-bn --device 0,1,2,3 --name yolov4-p6_flir --epochs 100
```
