# CMake

1.  [Variables determined by CMake](#1-Variables-determined-by-CMake-"CMakeFindPackageMode") "CMakeFindPackageMode"
2.  [Using OpenCV with gcc and CMake](#2-Using-OpenCV-with-gcc-and-CMake)
    - use find_package() and ${NAME_Libs}
    - target_link_libraries()
***

## 1 Variables determined by CMake "CMakeFindPackageMode"
### (${NAME_Libs})

 - *Info*: `CMakeFindPackageMode` [CMake module documentation](https://cmake.org/cmake/help/latest/module/CMakeFindPackageMode.html)
 - Stackoverflow [post](https://stackoverflow.com/questions/33981618/check-where-include-library-path-variables-like-opencv-libs-point-to-in-unix)

Those variables are determined by cmake (see OpenCVConfig.cmake for a more detailed description of opencv CMake variables available). 

To see those values you can add message() calls after the find_package(OpenCV) call to your project's CMakeLists.txt:

```
find_package(OpenCV)

message(STATUS "OpenCV_INCLUDE_DIRS = ${OpenCV_INCLUDE_DIRS}")
message(STATUS "OpenCV_LIBS = ${OpenCV_LIBS}")
```


Alternatively you can run find_package via a CMake command line option. 


Here are a few examples (the CMAKE_PREFIX_PATH part is optional if CMake is not able to find your libraries installation path automatically):


1. MODE=COMPILE giving include directories (e.g. with MSVC compiler)
```
    $ cmake 
        --find-package 
        -DNAME=OpenCV 
        -DCOMPILER_ID=MSVC -DMSVC_VERSION=1700 
        -DLANGUAGE=CXX 
        -DMODE=COMPILE 
        -DCMAKE_PREFIX_PATH:PATH=/path/to/your/OpenCV/build
```

2. MODE=LINK giving link libraries (e.g. with GNU compiler)
```
    $ cmake 
        --find-package 
        -DNAME=OpenCV 
        -DCOMPILER_ID=GNU 
        -DLANGUAGE=CXX 
        -DMODE=LINK 
        -DCMAKE_PREFIX_PATH:PATH=/path/to/your/OpenCV/build
```

*Note*: This CMake call will create a CMakeFiles sub-directory in your current working directory. 

***

## 2 Using OpenCV with gcc and CMake

- *Info*: [docs.opencv.org](https://docs.opencv.org/4.5.1/db/df5/tutorial_linux_gcc_cmake.html)

```
cmake_minimum_required(VERSION 2.8)
project( DisplayImage )
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )
add_executable( DisplayImage DisplayImage.cpp )
target_link_libraries( DisplayImage ${OpenCV_LIBS} )
```