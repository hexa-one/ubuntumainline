#! /usr/bin/env bash

KERNEL_VER="5.13.3"
VER_STR="051303"

while [[ $# -gt 0 ]]; do
  PROG_ARGS+=("${1}")
  case "${1}" in
    -amd|--amd64)
      mkdir /tmp/ubuntukernel$KERNEL_VER
      cd /tmp/ubuntukernel$KERNEL_VER
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/amd64/linux-headers-5.13.3-051303-generic_5.13.3-051303.202107190532_amd64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/amd64/linux-headers-5.13.3-051303_5.13.3-051303.202107190532_all.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/amd64/linux-image-unsigned-5.13.3-051303-generic_5.13.3-051303.202107190532_amd64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/amd64/linux-modules-5.13.3-051303-generic_5.13.3-051303.202107190532_amd64.deb
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
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/arm64/linux-headers-5.13.3-051303-generic_5.13.3-051303.202107190532_arm64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/arm64/linux-image-unsigned-5.13.3-051303-generic_5.13.3-051303.202107190532_arm64.deb
      wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.13.3/arm64/linux-modules-5.13.3-051303-generic_5.13.3-051303.202107190532_arm64.deb
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
