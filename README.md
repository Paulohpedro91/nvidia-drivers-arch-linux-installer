# nvidia-drivers-arch-linux-installer
 This bash script will install Xorg and the Nvidia drivers (LTS &amp; regular) for Arch Linux, and will notify the user if any error is encountered.

## Dependencies:
In order to run this project you will need the following packages
* pacman
* sudo or doas

## Usage guide: 

+ To install Nvidia drivers that support the latest kernel, run:
```sh
$ sudo install-nvidia.sh
```

+ To install Nvidia drivers that support the LTS kernel, run:
```sh
$ sudo install-nvidia.sh --lts
```


