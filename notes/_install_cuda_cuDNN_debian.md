### Install/Uninstall CUDA packages in Ubuntu

## Uninstall
For CUDA installed via. nvidia repository 
uninstall like this: 
```
sudo apt-get autoremove --purge cuda 
```
If there are additional installations of CUDA on the machine you might need: 
```
sudo apt-get purge cuda*
sudo apt-get --purge -y remove 'cuda*'
sudo apt-get --purge -y remove 'nvidia*'
sudo shutdown -r now
```

Uninstall leftover config files:
```
dpkg -l | grep '^rc' | awk '{print $2}' | grep cuda | sudo xargs dpkg --purge
dpkg -l | grep '^rc' | awk '{print $2}' | grep nvidia | sudo xargs dpkg --purge
```

```
sudo apt-get autoremove && \
sudo apt-get autoclean && \
sudo rm -rf /usr/local/cuda* && \
sudo shutdown -r now
```

Depending on the configuration you might need:
```
sudo apt remove cuda-drivers
```
Remove the cuDNN folder to simply uninstall.

## Install Driver and CUDA Toolkit locally via runfile installation
- **Info:** Nvidia local runfile [installation guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile)  

The Runfile installation installs the **NVIDIA Driver, CUDA Toolkit, and CUDA Samples** via an interactive ncurses-based interface. 

Stolen from "install_pyTorch_conda_scaledYolov4_Environment_wo_docker.md" 

## Install Drivers
To install the nvidia GPU-driver check the list of driver devices available for the nvidia card from the default Ubuntu repository: 
$ sudo ubuntu-drivers devices

Here we see "recommended" drivers and some additional ones. To install the specific driver we can either: 
$ sudo ubuntu-drivers autoinstall
or
$ sudo apt install nvidia-driver-460

Reboot
$ sudo shutdown -r now

Verify the installation: 
$ nvidia-smi

## [Install](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork) CUDA

See [pre-installation steps](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#pre-installation-actions).
See [Ubuntu install guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation).
See [Guide on how to install with deb files (that does not work for me)](https://medium.com/repro-repo/install-cuda-10-1-and-cudnn-7-5-0-for-pytorch-on-ubuntu-18-04-lts-9b6124c44cc).

*Ubuntu 18.04:*

*Install most recent CUDA*
```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin && \
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && \
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" && \
sudo apt-get update && \
sudo apt-get -y install cuda
```

To install a specific version, just use: 
```
sudo apt install cuda-11-0
```
See if we have the following folder present `/usr/local/cuda`, if not, create a Symlink: 
```
sudo ln -s /usr/local/cuda-11.0 /usr/local/cuda
```

*Install [specific version of CUDA](https://developer.nvidia.com/cuda-toolkit-archive)*
*CUDA v11.0 / this version does not work altough it is offical nvidia doc?*
```
sudo wget https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda-repo-ubuntu1804-11-0-local_11.0.3-450.51.06-1_amd64.deb && \
sudo dpkg -i cuda-repo-ubuntu1804-11-0-local_11.0.3-450.51.06-1_amd64.deb && \
sudo apt-key add /var/cuda-repo-ubuntu1804-11-0-local/7fa2af80.pub && \
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && \
sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin && \
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
sudo apt-get update && \
sudo apt-get -y install cuda
```

*Perform [post-installation actions](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions)*: 

Add the path to the PATH variable in .bashrc or .zshrc:
```
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

## Verify CUDA installation: 
$ nvcc --version

compile saxpy.cu that should result in Max error: 0.000
nvcc saxpy.cu -o test && \ 
./test

- More info [here](https://medium.com/repro-repo/install-cuda-10-1-and-cudnn-7-5-0-for-pytorch-on-ubuntu-18-04-lts-9b6124c44cc). 

```
cd /usr/local/cuda-10.0/samples && \
sudo make
```

let’s run two tests: deviceQuery and matrixMulCUBLAS. First, try deviceQuery:

```
/usr/local/cuda-10.0/samples/bin/x86_64/linux/release/deviceQuery
```

```
$ /usr/local/cuda-10.0/samples/bin/x86_64/linux/release/deviceQuery
/usr/local/cuda-10.0/samples/bin/x86_64/linux/release/deviceQuery Starting...CUDA Device Query (Runtime API) version (CUDART static linking)Detected 1 CUDA Capable device(s)Device 0: "GeForce GTX 1060"
  CUDA Driver Version / Runtime Version          10.0 / 10.0
  CUDA Capability Major/Minor version number:    6.1
  Total amount of global memory:                 6078 MBytes (6373572608 bytes)
  (10) Multiprocessors, (128) CUDA Cores/MP:     1280 CUDA Cores
  GPU Max Clock rate:                            1671 MHz (1.67 GHz)
  Memory Clock rate:                             4004 Mhz
  Memory Bus Width:                              192-bit
  L2 Cache Size:                                 1572864 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 2 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.0, CUDA Runtime Version = 10.0, NumDevs = 1
Result = PASS
```

Just to make sure we’ve configured CUDA correctly, run a computation-based test:

```
/usr/local/cuda-10.0/samples/bin/x86_64/linux/release/matrixMulCUBLAS
```

Result should be something like this: 

```
/usr/local/cuda-10.0/samples/bin/x86_64/linux/release/matrixMulCUBLAS

[Matrix Multiply CUBLAS] - Starting...
GPU Device 0: "GeForce GTX 1060" with compute capability 6.1GPU Device 0: "GeForce GTX 1060" with compute capability 6.1MatrixA(640,480), MatrixB(480,320), MatrixC(640,320)
Computing result using CUBLAS...done.
Performance= 2350.06 GFlop/s, Time= 0.084 msec, Size= 196608000 Ops
Computing result using host CPU...done.
Comparing CUBLAS Matrix Multiply with CPU results: PASSNOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.
```

## Install cuDNN
We can now install the Deep Neural Network library (cuDNN), which is a GPU-accelerated library of primitives for deep neural networks, by just downloading the file from https://developer.nvidia.com/cudnn

This needs to be done in browser since you need an nVidia dev account. 

Then issue the following commands, where your CUDA directory path is referred to as /usr/local/cuda/ and your cuDNN download path is referred to as <cudnnpath>:

Navigate to your <cudnnpath> directory containing the cuDNN Tar file.
```
sudo mkdir cuda-cudnn-11.2-linux-x64-v8.1.1.33 && \
sudo tar -xzvf cuda-cudnn-11.2-linux-x64-v8.1.1.33.tgz -C cuda-cudnn-11.2-linux-x64-v8.1.1.33 && \
cd cuda-cudnn-11.2-linux-x64-v8.1.1.33
```

# Copy the files to the CUDA Toolkit directory: 
```
sudo cp -dv cuda/include/cudnn*.h /usr/local/cuda-11.0/include && \
sudo cp -dv cuda/lib64/libcudnn* /usr/local/cuda-11.0/lib64 && \
sudo chmod a+r /usr/local/cuda-11.0/include/cudnn*.h /usr/local/cuda-11.0/lib64/libcudnn*
```

## Verify the cuDNN installation
- More info [here](https://medium.com/repro-repo/install-cuda-10-1-and-cudnn-7-5-0-for-pytorch-on-ubuntu-18-04-lts-9b6124c44cc). 

- Go to the MNIST example code: cd /usr/src/cudnn_samples_v7/mnistCUDNN/.
- Compile the MNIST example: sudo make clean && sudo make.
- Run the MNIST example: `./mnistCUDNN`. 


## Uninstall cuDNN
```
sudo rm /usr/local/cuda/include/cudnn*.h && \
sudo rm /usr/local/cuda/lib64/libcudnn*
```