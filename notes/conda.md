# Conda

0.  [Useful commands](#0-Useful-commands")
1.  [How to Use & Good to Know]("1-How-to-Use-&-Good-to-know")
    - Conda installs its own version of Python in an environment!
    - So, AFAIUnderstand
2.  [Anaconda vs. Miniconda](#2-Anaconda-vs.-Miniconda)
    - Choose Anaconda if you
    - Choose Miniconda if you
3.  [Conda Env Example with scaledYolov4](#3-Conda-Env-Example-with-scaledYolov4)
4.  [Setting up ROS with Python 3 and OpenCV](#4-Setting-up-ROS-with-Python-3-and-OpenCV)
    

* * *

## 0 Useful commands

* * *

*To see if the conda installation of Python is in your PATH variable:*
`echo $PATH`

*To see which packages are installed in your current conda environment and their version numbers:*
`conda list`

*To create & activate conda env with specific python version:*
`conda create -n NAME python=3.x -y && conda activate NAME`

*To create the environment from a file:*
`conda env create -f environment.yml`

*To see a list of all your environments, type: (*The active environment is the one with an asterisk.*)*
`conda info --envs`

*To delete an environment:*
`conda env remove -n NAME`

* * *

## 1 How-to-Use & Good-to-know

* * *

### Conda installs its own version of Python in an environment! See: [Conda Docs](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html#installing-conda-on-a-system-that-has-other-python-installations-or-packages)

```
- "Installing conda on a system that has other Python installations or packages: You do not need to uninstall other Python installations or packages in order to use conda. Even if you already have a system Python, another Python installation from a source such as the macOS Homebrew package manager and globally installed packages from pip such as pandas and NumPy, you do not need to uninstall, remove, or change any of them before using conda." 
```

Install Anaconda or Miniconda normally, and let the installer add the conda installation of Python to your PATH environment variable. There is no need to set the PYTHONPATH environment variable.

To see if the conda installation of Python is in your PATH variable:
\- On Windows, open an Anaconda Prompt and run `echo %PATH%`.
\- On macOS and Linux, open the terminal and run `echo $PATH`.

To see which Python installation is currently set as the default:
\- On Windows, open an Anaconda Prompt and run `where python`.
\- On macOS and Linux, open the terminal and run `which python`.

To see which packages are installed in your current conda environment and their version numbers, in your terminal window or an Anaconda Prompt, run `conda list`.

### So, AFAIUnderstand:

We can easily create & activate a conda environment by just choosing what python version it should install with the new environment with:

```
conda create -n NAME python=3.8 -y
conda activate NAME
```

**And there, i can install via `pip` as well as `conda`, which then should be system wide available through having the conda installation of Python in my PATH!**

This is somewhat other than with virtual environments as far as i know, but on second thought I just did not realize how virtualenv works!?

### apt install vs. conda install

So, the bindings are a little bit tricky:

I think, when you install some package outside the conda environment with apt, it is system wide available!
When you install it inside, it is still system-wide, but probably the bindings don't work?

Example: I installed `python3-opencv` and `import cv2` only is available outside the `base` environment.

One other example with conda suggests the following, from where we see that it is kind of separated:

```
#... To use protobuf inside conda environment, type:
conda install protobuf

#... To use the protobuf outside of conda environment (system level), type:
apt-get install python-protobuf
```

But packages like `bat` are available system-wide!

See [conda environments](https://conda.io/projects/conda/en/latest/user-guide/concepts/environments.html)

* * *

## 2 Anaconda vs. Miniconda

* * *

### Choose Anaconda if you:

- Are new to conda or Python
- Like the convenience of having Python and over 1500 scientific packages automatically installed at once
- Have the time and disk space (a few minutes and 3 GB), and/or
- Don’t want to install each of the packages you want to use individually.

### Choose Miniconda if you:

- Do not mind installing each of the packages you want to use individually.
- Do not have time or disk space to install over 1500 packages at once, and/or
- Just want fast access to Python and the conda commands, and wish to sort out the other programs later.

**Quote from [Install Miniconda Ubuntu 18.04](https://varhowto.com/install-miniconda-ubuntu-18-04/)**
*Miniconda is an installer which is minimally free of Conda. It’s a thin, bootstrap version that includes just conda, Python, the packages they rely on, and a limited range of other useful modules like pip, zlib, and a few others.*

**Quote from [Stackoverflow-Post](https://stackoverflow.com/questions/45421163/anaconda-vs-miniconda)**

*I use Miniconda myself. Anaconda is bloated. Many of the packages are never used and could still be easily installed if and when needed.*

*Note that Conda is the package manager (e.g. conda list displays all installed packages in the environment), whereas Anaconda and Miniconda are distributions. A software distribution is a collection of packages, pre-built and pre-configured, that can be installed and used on a system. A package manager is a tool that automates the process of installing, updating, and removing packages.*

*Anaconda is a full distribution of the central software in the PyData ecosystem, and includes Python itself along with the binaries for several hundred third-party open-source projects. Miniconda is essentially an installer for an empty conda environment, containing only Conda, its dependencies, and Python. [Source](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/).*

*Once Conda is installed, you can then install whatever package you need from scratch along with any desired version of Python.*

* * *
## 3 Conda Env Example with scaledYolov4
* * *

**Start with scaled-yolov4:**

- *Info:* [Ikuokuo Github Repo](https://github.com/ikuokuo/start-scaled-yolov4)!

*... creating a working folder*

```
mkdir ML
```

*... install CUDA Toolkit*

```
wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run && \
sudo sh cuda_10.2.89_440.33.01_linux.run
```

*Mish-CUDA*

**Install mish-cuda:**

- Info: if you use different pytorch version, you could try https://github.com/thomasbrandon/mish-cuda

```
cd / && \
git clone https://github.com/JunnYu/mish-cuda && \
cd mish-cuda && \
python setup.py build install
```

**Get [ScaledYOLOv4-large](https://github.com/WongKinYiu/ScaledYOLOv4/tree/yolov4-large)**

```
git clone -b yolov4-large https://github.com/WongKinYiu/ScaledYOLOv4
```

*... create requirements file if needed*

```
touch requirements.txt && \ 
echo pycocotools>=2.0.2 >> requirements.txt
```

**Create conda environment with Python version**

```
conda create -n scaled-yolov4 python=3.8 -y
conda activate scaled-yolov4
cd ML 
pip install -r requirements.txt
```

*PyTorch with CUDA*
conda install pytorch1.7.1 torchvision0.8.2 cudatoolkit=10.2 -c pytorch -y

- [pyTorch Installation](https://github.com/pytorch/vision#installation)
- [CUDA Toolkit Compatible driver Versions](https://docs.nvidia.com/deploy/cuda-compatibility/index.html#binary-compatibility__table-toolkit-driver)

* * *
## 4 Setting up ROS with Python 3 and OpenCV
*** 
-**Info:** [idorobotics.com](https://idorobotics.com/2020/08/19/setting-up-ros-with-python-3-and-opencv/)

The Robot Operating System (ROS) does not currently work out-of-the-box with Python 3. ROS officially supports Python 2.7 and ROS 2 supports Python 3 natively. Since Python 2.7 support is now deprecated, and most robots in 2020 still use ROS (not ROS 2), it becomes neccessary to set up Python 3 with ROS in order to take full advantage of the latest features in many useful libraries/toolboxes which require Python 3 to run. Setting up virtual environments (for example conda envs) for Python projects is also recommended practice, however getting Anaconda to work with ROS can be tricky.

This brief tutorial offers a step by step guide for running ROS with Python 3 and OpenCV from within a conda environment. It’s worthwhile noting that I use ROS Kinetic which is default complied with Python 2.7 instead of reinstalling and compiling ROS with Python 3. Assuming that a Python 3 conda environment has already been set up and activated (see this tutorial for details of how to do so) proceed with the steps below.

***TODO:*** useful?