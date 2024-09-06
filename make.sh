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
# Hardlink to specified sources (can be used to reduce Docker context size)
#ln Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip build/
ln Xilinx_ISE_DS_Lin_14.7_1015_1.tar build/
ln Xilinx_2017.lic build/
ln ise14_install_config.txt build/

# Build
docker build -t ise14.7-base -f Dockerfiles/Dockerfile.base build/
#docker build -t ise14.7-builder -f Dockerfiles/Dockerfile.builder_archive_hdd build/
#docker build -t ise14.7-builder -f Dockerfiles/Dockerfile.builder_archive_tmpfs build/
docker build -t ise14.7-builder -f Dockerfiles/Dockerfile.builder_installer_tmpfs build/
docker build -t ise14.7-gui-system-complete-all -f Dockerfiles/Dockerfile.ise14.7-gui-system-complete-all build/

# Cleanup
rm -rf build
