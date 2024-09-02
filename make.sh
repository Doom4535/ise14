#!/usr/bin/env bash

# Enable BuildKit (if it isn't already enabled)
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# TODO: Add flags to enable exluding the License file and
# to enable copying it from another path
# TODO: Add flags to enable copying install config file
# from another location

# Make builddir (used to reduce the context size with large install files)
![ -d build ] && mkdir build

# From base
docker build -t ise14-base -f Dockerfiles/Dockerfile.base build/
#mv Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip build/
#docker build -t ise14-builder -f Dockerfiles/Dockerfile.builder_archive_hdd build/
#docker build -t ise14-builder -f Dockerfiles/Dockerfile.builder_archive_tmpfs build/
#mv build/Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip .
mv {Xilinx_ISE_DS_Lin_14.7_1015_1.tar, Xilinx_2017.lic, Xilinx_ISE_DS_Lin_14.7_1015_1.tar} build/
docker build -t ise14-builder -f Dockerfiles/Dockerfile.builder_installer_tmpfs build/
mv build/{Xilinx_ISE_DS_Lin_14.7_1015_1.tar, Xilinx_2017.lic, Xilinx_ISE_DS_Lin_14.7_1015_1.tar} .
docker build -t ise14.7-gui-system-complete-all -f Dockerfiles/Dockerfile.gui-ise14.7-system-complete-all build/
