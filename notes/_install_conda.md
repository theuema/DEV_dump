## Conda Installation

* * *

### Linux

- **Info:** [Install Miniconda Ubuntu 18.04](https://varhowto.com/install-miniconda-ubuntu-18-04/)
    - Also newer versions are available! (Ubuntu 20.xx)

Choose the *standard* python version you want to use with conda (others can easily be chosen during the creation of a new environment!) via. the installer script [here](https://docs.conda.io/en/latest/miniconda.html#linux-installers), or just use the latest version with:

```
cd && \ 
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
chmod +x Miniconda3-latest-Linux-x86_64.sh && \
./Miniconda3-latest-Linux-x86_64.sh
```

**When you begin using conda, you already have a default environment named base.**
You don't want to put programs into your base environment, though. Create separate environments to keep your programs isolated from each other.

**The base environment is activated as default if we choose to use `conda init` at the last step of installation!**

#### Zsh

Use the conda shell.zsh hook in `bash` to configure conda for `zsh` too:

```
conda shell.zsh
```

To use [conda-zsh-completion](https://github.com/esc/conda-zsh-completion/blob/master/_conda) with oh-my-zsh:

```
# clone the plugin to the custom plugin folder for oh-my-zsh:
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion

# And add lines in `.zshrc`
#     plugins=(… conda-zsh-completion)
#     autoload -U compinit && compinit

```

### To prevent Miniconda from activating base environment:

If you'd prefer that conda's base environment not be activated on startup,
set the auto\_activate\_base parameter to false:

```
conda config --set auto_activate_base false
```

### To prevent Miniconda from activating base environment (alternative):

- **Info:** [Install Miniconda Ubuntu 18.04](https://varhowto.com/install-miniconda-ubuntu-18-04/)

By default, conda init adds the base environment to your .bashrc file on your Ubuntu 18.04 OS which slows down your terminal.

You can delete them in your.bashrc file, or answer no to that question in the last step of your miniconda installation on Ubuntu 18.04.

And then add the following to your .bashrc file. If you have modified the default Miniconda installation directory, change ~/miniconda3/ to that directory.

```
source ~/miniconda3/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
    export PATH="~/conda/bin:$PATH"
fi
```

To test it, open a new terminal tab or run `source .bashrc`.
Run `conda activate base`, then you should see (base) in front of your Bash prompt.

Open a new terminal tab or run the .bashrc file to verify it.
Run `conda activate base`, then you will see (base) in front of your Bash prompt.

### General post-install-information on environments:

You can always choose another python version when creating an environment with:

```
conda create --name NAME python=3.x
```

**Optional: Create and activate an conda environment**
To create a conda environment, run

```
conda create -n NAME
conda activate NAME
```

You can also create the environment from a file like environment.yml, you can use use the conda `env create -f` command: The environment name will be the directory name.

```
conda env create -f environment.yml
```

* * *