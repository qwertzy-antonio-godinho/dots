# dots

This repository contains my dot configuration files and a simple installer script that I use to install and setup a voidlinux system.

*Note:*
Using the voidlinux installer, the installer does not create a regular user (might be a bug with the installer or maybe just me), I have to create a user after installation by issuing the command ```useradd -m <USER_NAME>```, add the user to the wheel group ```gpasswd --add <USER_NAME> wheel``` and add a password to the new user ```passwd <USER_NAME>```. 

After login as the new user, delete all existing dots ```rm -rf ~* && rm -rf ~/.*```, install git ```sudo xbps-install git --yes```, clone this repository ```git clone https://github.com/qwertzy-antonio-godinho/dots``` and run ```dots.sh``` script. Next step is to run the ```ass.sh``` script to setup the system.

## Setting up the system

A fresh voidlinux installation can be setup by using the ```ass.sh``` script. This script installs software packages and sets up the current logged in user with prefered settings.

## Managing the dots

The dot files are managed locally using the ```dots.sh``` script.

### What does the script do?

This script looks for a givel file modification date in a SOURCE and TARGET location to identify the latest version.

The script creates a directory tree just like the directory structure defined inside the SOURCE ```home``` directory. Any directories not present in the target location will be created if they do not exist.

This is followed by the creation of a symbolic link or a copy of the file in the TARGET destination location for each of the files present in the SOURCE ```home``` directory.

A symbolic link is created in the target location if the source file is a regular file, in case the source file is a symbolic link itself then a copy of the file as a regular file is made to prevent symlinking a symlink. There is also the edge-case of some programs replacing the symlinked file with a regular file when updates to the settings are made (volumeicon applet).

### How to use?

**Upon execution the script does not make any changes, instead it will display a list of the changes it will make.** This list, is a list of updates to be made on the SOURCE or TARGET destination depending on where they are different.

**To accept and apply the changes listed, run the script with:**

- ```--no-dry-run``` to apply updates to SOURCE AND TARGET locations

### Source Vs Target

***SOURCE destination*** refers to the directory containing the original dot files, this location is defined in the script by the variable ```DOTS_HOME_SOURCE```.

***TARGET destination*** refers to the destination where the dot files are to be copied/symlinked to. This is set to be the user home directory. This variable is also defined in the script by the variable ```DOTS_HOME_TARGET```.

### Usage tips

- See changes to SOURCE: ```./dots.sh | grep "UPDATE-SOURCE"```

- See changes to TARGET: ```./dots.sh | grep "UPDATE-TARGET"```

### Disclaimer

I use this script to manage my dot files, and it works well for my needs. **It might not work for yours.**

Do not blindly execute someone else's scripts on your machine without first looking at the source code and seeing for yourself what it does.
