# Install and use pyTorch with scaledYolov4 fast only with Anaconda
# start-scaled-yolov4!
- *Info:* [Ikuokuo Github Repo](https://github.com/ikuokuo/start-scaled-yolov4)!

*Start with creating a working folder*

```
mkdir ML
```

*Install CUDA Toolkit*

```
wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run && \
sudo sh cuda_10.2.89_440.33.01_linux.run
```

*Mish-CUDA*

```
# install mish-cuda, if you use different pytorch version, you could try https://github.com/thomasbrandon/mish-cuda
```
# cd / && \
git clone https://github.com/JunnYu/mish-cuda && \
cd mish-cuda && \
python setup.py build install
```

*Get [ScaledYOLOv4-large](https://github.com/WongKinYiu/ScaledYOLOv4/tree/yolov4-large)*

```
git clone -b yolov4-large https://github.com/WongKinYiu/ScaledYOLOv4
```

*Create requirements file if needed*
```
touch requirements.txt && \ 
echo pycocotools>=2.0.2 >> requirements.txt
``` 

*Create conda environment with Python version*
```
conda create -n scaled-yolov4 python=3.8 -y
conda activate scaled-yolov4
```

```
# cd ML && \ 
pip install -r requirements.txt
```

*PyTorch with CUDA*
conda install pytorch==1.7.1 torchvision==0.8.2 cudatoolkit=10.2 -c pytorch -y

 - [pyTorch Installation](https://github.com/pytorch/vision#installation)
 - [CUDA Toolkit Compatible driver Versions](https://docs.nvidia.com/deploy/cuda-compatibility/index.html#binary-compatibility__table-toolkit-driver)


