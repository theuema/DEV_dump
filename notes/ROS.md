# ROS

0.  [0 Useful commands & packages](0-Useful-commands-&-packages)
    -  commands
        -  roscore
        -  rqt_bag
    -  packages
        -  bagpy

- *Info: Installation instructions can be found in `DEV_notes/install_setup_ROS.md`*

***
## 0 Useful commands
*** 

### commands

#### [roscore](https://wiki.ros.org/roscore) 
... is a collection of nodes and programs that are pre-requisites of a ROS-based system. You must have a roscore running in order for ROS nodes to communicate. It is launched using the roscore command. 

roscore will start up:
 - a ROS Master
 - a ROS Parameter Server
 - a rosout logging node 

The roscore can be launched using the roscore executable: 
```
roscore

# You can also specify a port to run the master on
roscore -p 1234
```

#### [rqt_bag](https://wiki.ros.org/rqt_bag)
... provides a GUI plugin for displaying and replaying ROS bag files.

rqt_bag is an application for recording and managing bag files. Primary features:
 - show bag message contents
 - display image messages (optionally as thumbnails on a timeline)
 - plot configurable time-series of message values
 - publish/record messages on selected topics to/from ROS
 - export messages in a time range to a new bag 

```
rqt_bag animal_pose_bag.bag
```

### packages

#### [bagpy](https://pypi.org/project/bagpy/)
... is a python class to facilitate the reading of rosbag file based on semantic datatypes.

```
pip install bagpy
```

***
