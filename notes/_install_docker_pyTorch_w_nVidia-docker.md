# Install docker engine with nVidia-docker with pyTorch
- See overview, of [running PyTorch in Docker Container](https://alvissalim.com/2020/05/16/running-pytorch-in-docker-container/).

## Install docker engine
- As described in the official docker docs on [how to install docker engine](https://docs.docker.com/engine/install/ubuntu/).

Once installation is successful, we need to add current user to the docker user group to allow current user to run docker without needing to call sudo. This is done by creating a docker user group.

```
## probably the group docker already exists, no need for the first command.
sudo groupadd docker 

sudo usermod -aG docker $USER && \
newgrp docker
```

- for more post-installation instructions, refer to the [official post-installation guide](https://docs.docker.com/engine/install/linux-postinstall/).

## Install Nvidia-docker
- As described in the official [nvidia-docker github](https://github.com/NVIDIA/nvidia-docker).

The installation process looks something like this: 

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list


sudo apt-get update && sudo apt-get install -y nvidia-docker2 && \
sudo systemctl restart docker
```

At this point, a working setup can be tested by running a base CUDA container:

```
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

This should result in a console output shown below:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.51.06    Driver Version: 450.51.06    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
| N/A   34C    P8     9W /  70W |      0MiB / 15109MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

## Running PyTorch container

Once docker is setup properly, we can run the container using the following commands:

```
nvidia-docker run --name nvpytorchtest -it --shm-size=64g nvcr.io/nvidia/pytorch:20.06-py3
```

The above command will run a new container based on the PyTorch image specified by “pytorch/pytorch:1.5-cuda10.1-cudnn7-devel”. This will run container with PyTorch 1.5 with cuda 10.1 setup in the container. 
- The complete list of images can be found [HERE](https://hub.docker.com/r/pytorch/pytorch)! under "tags".
- A list of official nVidia conatainers can be found [HERE](https://ngc.nvidia.com/catalog/containers?orderBy=modifiedDESC&pageNumber=1&query=&quickFilter=containers&filters=)!

We will now test if PyTorch is correctly setup in the container. From within the container, try to run python and run the following commands

```
python -c "import torch; print(torch.__version__)"
```

or

```
python
import torch
print(torch.__version__)
```

Also check if OpenCV bindings are in place: 
```
python3 -c "import cv2; print(cv2.__version__)"
```

## Use ScaledYOLO with docker container
- *Info* on the official ScaledYOLOv4 [Github page](https://github.com/WongKinYiu/ScaledYOLOv4/tree/yolov4-large).

Create MachineLearning (ML) folder in $HOME for data and weights outside of the docker container: 
```
cd && \
mkdir ML && cd ML && \
git clone https://github.com/WongKinYiu/ScaledYOLOv4.git && git checkout yolov4-large
```

Download officialy trained weights from the COCO Dataset and ScaledYOLOv4-large model from the official [github page](https://github.com/WongKinYiu/ScaledYOLOv4/tree/yolov4-large).
For example, download and clone yolov4-p6.pt to the folder called "weights" in the ScaledYOLOv4 folder. 

We now use define YOLO as -v (volume) and start with our newly installed pytorch container: 
```
nvidia-docker run --name yolov4_csp -it -v /home/theuema/ML:/ML/ --shm-size=64g nvcr.io/nvidia/pytorch:20.06-py3
```

# Install mish-cuda [Mish-Cuda](https://github.com/JunnYu/mish-cuda): Self Regularized Non-Monotonic Activation Function

```
cd / && \
git clone https://github.com/JunnYu/mish-cuda && \
cd mish-cuda && \
python setup.py build install
```

As an example, we can make a folder in `~/ML/Dataset/Images` and detect classes with the Object detector:

```
python detect.py --weights weights/yolov4-p6.pt --source ../Dataset/Images/ --output ../Output/Images_inf
```

The source can be folders or a file, it can be videos or images, just that easy. 