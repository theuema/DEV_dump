## ROS Installation and Setup

### General Information

See the different [distributions](https://wiki.ros.org/Distributions) to get an idea which distro can be installed on what platform! 

For example, [ROS Melodic Morenia](https://wiki.ros.org/melodic) has the target platform *Ubuntu 18.04 (Bionic)*, meaning, that by installing via. packagemanager we can only get that version!

[ROS Noetic Ninjemys](https://wiki.ros.org/noetic) targets the *Ubuntu 20.04 (Focal)* release!

### Ubuntu 18.04
- **Info:** [Installation of melodic official documentation](https://wiki.ros.org/melodic/Installation/Ubuntu)

**Compact installation instruction:**

```
# Allow "restricted," "universe," and "multiverse" repos on Ubuntu
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

# Setup your computer to accept software from packages.ros.org
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys (sudo apt install curl # if you haven't already installed curl)
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Update ubuntu repos
sudo apt update 

# Desktop-Full Install: ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators and 2D/3D perception 
sudo apt install ros-melodic-desktop-full

# Desktop Install: ROS, rqt, rviz, and robot-generic libraries 
sudo apt install ros-melodic-desktop

# ROS-Base: (Bare Bones) ROS package, build, and communication libraries. No GUI tools. 
sudo apt install ros-melodic-ros-base

# Individual Package: You can also install a specific ROS package (replace underscores with dashes of the package name): (e.g.: package with name "ros-melodic-slam-gmapping")
sudo apt install ros-melodic-PACKAGE 

# To find available packages, use: 
apt search ros-melodic

```

**Environment installation instruction:**

Bash:
```
echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc
source ~/.bashrc
```

Zsh:
```
echo "source /opt/ros/melodic/setup.zsh" >> $HOME/.zshrc
source ~/.zshrc
```

**To start up a more specified ROS environment**, we can use a setup script instead of the source commands from above: 

Create `setup_ros_environment.sh` in your home directory (or wherever you want) and insert the following to your `~/.zshrc` or `~/.bashrc`: (Watch out for ROS distro and if we use bash or zsh!)
```
source /opt/ros/melodic/setup.bash # or .zsh
export ROS_MASTER_URI=http://GEOSMC-TX2-DEV:11311
export ROS_HOSTNAME=GEOSMC-TX2-DEV
```

Then just source the following in your `~/.zshrc` or `~/.bashrc`:
```
source /usr/src/ROS_MITA/setup_ros_environment.sh
```

**Up to now you have installed what you need to run the core ROS packages. To create and manage your own ROS workspaces, there are various tools and requirements that are distributed separately! See the next chapter.**

### Uninstall ROS
Simply execute in bash: (really bash since zsh don't work with the asteriks)
`sudo apt-get remove ros-*`

If you've created a workspace, you'll have to also remove that... 
and if you added the setup scripts to your .bashrc, you'd have to remove them too.

***
## 2 Dependencies for building packages
*** 
- **Info:** [Installation of melodic official documentation](https://wiki.ros.org/melodic/Installation/Ubuntu)

Up to now you have installed what you need to run the core ROS packages. To create and manage your own ROS workspaces, there are various tools and requirements that are distributed separately. For example, rosinstall is a frequently used command-line tool that enables you to easily download many source trees for ROS packages with one command. 

*** 
## 3 Python
*** 

Python imports should be directly available in python (? when we source our `/opt/ros/melodic/setup.bash` in bash or zsh)! 

Simply try the following: 
```
python3 -c "from cv_bridge import CvBridge"
```

*** 
## 4 OpenCV
*** 

The ROS package seems to install OpenCV from apt packagemanager(!) as well, just try the following after the installation: 
```
python3 -c "import cv2; print(cv2.__version__)"
```

For more Information about OpenCV head to the joplin OpenCV documentation!