# Install OpenCV on Linux
- Information on how to [install OpenCV on Ubuntu 18.04](https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/).
- Information on [OpenCV and CMake](https://docs.opencv.org/4.5.1/db/df5/tutorial_linux_gcc_cmake.html).

0.  [0 Useful commands](0-Useful-commands)

1.  [1 Pre-Installation](1-Pre-Installation)
2.  [2 Install OpenCV for Python from the Ubuntu Repository](2-Install-OpenCV-for-Python-from-the-Ubuntu-Repository)
3.  [3 Build OpenCv from source and use in a virtual environment](3-Build-OpenCv-from-source-and-use-in-a-virtual-environment)


*** 

## 0 Useful commands

*** 
## 1 Pre-Installation
*** 
Check if OpenCV is installed:
```
pkg-config --modversion opencv
```

Get version:
```
dpkg -l | grep libopencv
```

Get build info on Jetson:
```
opencv_version -v
```

Install the required dependencies:
```
sudo apt install build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev
```

*** 
## Install OpenCV for Python from the Ubuntu Repository
*** 
The OpenCV package is available from the Ubuntu 18.04 distribution repository. At the time of writing, the version in the repositories is 3.2, which is not the latest version.

`sudo apt update && sudo apt install python3-opencv`

To verify the installation, import the cv2 module and print the OpenCV version:

`> python3 -c "import cv2; print(cv2.__version__)"`
`> 3.2.0`

- Info: The default Python version in Ubuntu 18.04 LTS is version 3.6. If you want to install OpenCV with python 2 bindings install the `python-opencv` package.

***
## 3 Build OpenCv from source and use in a virtual environment
*** 
As usual, use `sudo -s` to build and install this Package. 

*Clone the OpenCV’s and OpenCV contrib repositories:*
If you want to install an older version of OpenCV, 
cd to both opencv and opencv_contrib directories and run `git checkout <opencv-version>`

```
mkdir /usr/src/OpenCV && cd /usr/src/OpenCV && \
git clone https://github.com/opencv/opencv.git && \
git clone https://github.com/opencv/opencv_contrib.git
```

Important is now to switch to you virutalenv you want to use
`workon <env name>`

Since NumPy is a requirement for working with Python and OpenCV: 
`pip3 install numpy`

*Build OpenCV to specified build folder with CMake:*

```

mkdir -p -- /usr/build /usr/build/OpenCV && cd /usr/build/OpenCV && \
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D BUILD_opencv_python3=yes \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/usr/src/OpenCV/opencv_contrib/modules \
    -D PYTHON3_EXECUTABLE=/opt/conda/bin/python \
    -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.8.so \
    -D WITH_CUDA=ON \
    -D ENABLE_FAST_MATH=ON \
    -D CUDA_FAST_MATH=ON \
    -D WITH_CUBLAS=ON \
    -D BUILD_EXAMPLES=ON \
    --build . ../../src/OpenCV/opencv
```
- **optional**:
    - -D PYTHON3_EXECUTABLE=/opt/conda/bin/python 
    - -D PYTHON_EXECUTABLE=/home/mth/.virtualenvs/yolo/bin/python3
    - -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.8.so

    - -D CUDA_SDK_ROOT_DIR=/usr/local/cuda-11.0 \

Check the python3 Interpreter: 

```
--   Python 3:
--     Interpreter:                 /usr/bin/python3.4 (ver 3.4.3)
--     Libraries:                   /usr/lib/x86_64-linux-gnu/libpython3.4m.so (ver 3.4.3)
--     numpy:                       /usr/lib/python3/dist-packages/numpy/core/include (ver 1.8.2)
--     packages path:               lib/python3.4/dist-packages
```


Cmake build system should finalize with something like this: 
```
Configuring done.
Generating done.
Build files have been written to ...
```

Compile and Install OpenCV.
We now start the compilation process: Modify the -j flag according to your processor!
If you do not know the number of cores your processor, you can find it by typing `nproc`.
```
cd /usr/build/OpenCV && \
make -j12 && \
make install && \
ldconfig
```

To verify whether OpenCV has been installed successfully. 
Type the following command and you should see the OpenCV version:
```
pkg-config --modversion opencv4
```

**At this point, the Python3 bindings for OpenCV reside in a wrong folder. Best way is to go to**

/usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so
or cd `~/opencv_build_opencv/build/lib/python3`

and use the file cv2.cpython-36m-x86_64-linux-gnu.so directly with a simlink binding into our chosen virtual environment: 
```
$ sudo cp cv2.cpython-36m-x86_64-linux-gnu.so cv2.cpython-36m-x86_64-linux-gnu.so_backup
$ sudo mv cv2.cpython-36m-x86_64-linux-gnu.so cv2.so

$ cd ~/.virtualenv/<env name>/lib/python3.x/site-packages/
$ ln -s ~/opencv_build/opencv/build/lib/python3/cv2.so cv2.so
```
Go to root, deactivate and activate environment: 
```
$ cd
$ deactivate
$ workon <env name>
```

Check if openCV is working:
`$ python3 -c "import cv2; print(cv2.__version__)"`

Check build with CUDA and cuDNN
`$ python3 -c "import cv2; print(cv2.getBuildInformation())"`