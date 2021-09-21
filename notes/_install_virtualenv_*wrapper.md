# Virtualenv

1. [1 Install virtualenv on Ubuntu for python3](1-Install-virtualenv-on-Ubuntu-for-python3)
2. [2 Virtualenv _ Add libraries and create a requirements.txt file](2-Virtualenv-_-Add-libraries-and-create-a-requirements.txt-file)

* * *

# 1 Install virtualenv on Ubuntu for python3
- **Info:** [Realpython](https://realpython.com/python-virtual-environments-a-primer/)
- Virtualenvwrapper [documentation](https://virtualenvwrapper.readthedocs.io/en/latest/)

**Install pip for Python3**
`sudo apt-get install python3-pip`

**(I think) It doesn't matter if we install virtualenv with pip or pip3**
`pip install virtualenv`

**With the following command under Linux, virtualenvwrapper might not located in /usr/local/bin (therefore use `sudo pip3 install virtualenvwrapper`), but instead in ~/.local/bin/**
`pip3 install virtualenvwrapper`

**Add the following to your .zshrc and create directories .virtualenvs and /projects**
```
export WORKON_HOME=$HOME/.virtualenvs   # Optional
export PROJECT_HOME=$HOME/projects      # Optional
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
```

use either:
```
source /home/mth/.local/bin/virtualenvwrapper.sh
```
or
```
source /usr/local/bin/virtualenvwrapper.sh
```

***

## 2 Virtualenv _ Add libraries and create a requirements.txt file

- **Info:** [Article](https://mothergeo-py.readthedocs.io/en/latest/development/how-to/venv.html#add-libraries-and-create-a-requirements-txt-file)
- *Keywords:* python packages, pip requirements, docker container

After you activate the virtual environment, you can add packages to it using pip. You can also create a description of your dependencies using pip.
The following command creates a file called requirements.txt that enumerates the installed packages.
`pip freeze > requirements.txt`

This file can then be used by collaborators to update virtual environments using the following command.
`pip install -r requirements.txt`

## ldconfig
In order to share the new libraries we need to add a config where the system looks for libraries. 
The folder we need to add our library is `/etc/ld.so.conf.d/`. 
`/etc/ld.so.conf` is a file containing a list of colon, space, tab, newline, or comma-separated directories in which to search for libraries. `/lib/ld.so` is the run-time linker/loader. `/etc/ld.so.cache` is a file containing an ordered list of libraries found in the directories specified in /etc/ld.so.conf:

```
    touch /etc/ld.so.conf.d/boost-custom-lib.conf && \
    echo '/opt/boost/1.65.1/lib' >> /etc/ld.so.conf.d/boost-custom-lib.conf && \
    ldconfig 
```
Check shared libraries for libboost python library from /opt/boost:
`ldconfig -p | grep libboost_python`
