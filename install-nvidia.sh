#!/bin/bash
#
#	Copyright (c) 2015 - 2025, Paulo Henrique
#	All rights reserved.
#
#	Redistribution and use in source and binary forms, with or without
#	modification, are permitted provided that the following conditions are met:
#
#	1. Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#	2. Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#	3. Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
#	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

RED='\033[0;31m'
RESET='\033[0m'
KERNEL="$(uname -r)"

function rootCheck(){
	if [ "$USER" != "root" ]; then
		echo "$RED You need to be root to run this script... $RESET"
		exit 1
	fi
}

function xorgInstall(){
	pacman -S xorg xorg-server

	if [ "$?" != "0" ]; then
		echo "$RED An error occurred while installing Xorg $RESET"
		exit 1
	fi
}

function nvidiaInstall(){
	pacman -S nvidia nvidia-utils nvidia-settings opencl-nvidia

	if [ "$?" != "0" ]; then
		echo "$RED An error occurred while installing the NVIDIA drivers on kernel $KERNEL $RESET"
		exit 1
	fi

	cat /usr/lib/modprobe.d/nvidia-lts.conf
}

function nvidiaInstallLTS(){
	pacman -S nvidia-lts nvidia-utils nvidia-settings opencl-nvidia

	if [ "$?" != "0" ]; then
		echo "$RED An error occurred while installing the NVIDIA LTS drivers on kernel $KERNEL LTS $RESET"
		exit 1
	fi

	cat /usr/lib/modprobe.d/nvidia-lts.conf
}

rootCheck
xorgInstall

case $1 in

	--lts)
		nvidiaInstallLTS
		;;
	*)
		nvidiaInstall
		;;
esac

exit 0
