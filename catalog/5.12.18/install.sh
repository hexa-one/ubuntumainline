#! /usr/bin/env bash

KERNEL_VER="5.12.18"
VER_STR="051218"

while [[ $# -gt 0 ]]; do
  PROG_ARGS+=("${1}")
  case "${1}" in
    -amd|--amd64)
      mkdir /tmp/ubuntukernel$KERNEL_VER
      cd /tmp/ubuntukernel$KERNEL_VER
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/amd64/linux-headers-5.12.18-051218-generic_5.12.18-051218.202107190932_amd64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/amd64/linux-headers-5.12.18-051218_5.12.18-051218.202107190932_all.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/amd64/linux-image-unsigned-5.12.18-051218-generic_5.12.18-051218.202107190932_amd64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/amd64/linux-modules-5.12.18-051218-generic_5.12.18-051218.202107190932_amd64.deb
      sudo dpkg -i *.deb
      cd
      rm -r /tmp/ubuntukernel$KERNEL_VER
      if [ -f "/boot/initrd.img-$KERNEL_VER-$VER_STR-generic" ] 
      then
          echo linux $KERNEL_VER is successfully installed!
      else
          echo an error occurred while installing
      fi
      break
      ;;
    -arm|--arm64)
      mkdir /tmp/ubuntukernel$KERNEL_VER
      cd /tmp/ubuntukernel$KERNEL_VER
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/arm64/linux-headers-5.12.18-051218-generic_5.12.18-051218.202107190932_arm64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/arm64/linux-image-unsigned-5.12.18-051218-generic_5.12.18-051218.202107190932_arm64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12.18/arm64/linux-modules-5.12.18-051218-generic_5.12.18-051218.202107190932_arm64.deb
      sudo dpkg -i *.deb
      cd
      rm -r /tmp/ubuntukernel$KERNEL_VER
      break
      ;;
    -r|--remove)
      echo only remove kernel if you have a newer one!
      sleep 2
      sudo apt remove linux-headers-$KERNEL_VER-$VER_STR
      sudo apt remove linux-image-unsigned-$KERNEL_VER-$VER_STR-generic 
      sudo apt remove linux-modules-$KERNEL_VER-$VER_STR-generic
      if [ -f "/boot/initrd.img-$KERNEL_VER-$VER_STR-generic" ] 
      then
          echo linux $KERNEL_VER is successfully removed!
      else
          echo an error occurred while removing linux $KERNEL_VER
      fi
      break
      ;;
        esac
done
