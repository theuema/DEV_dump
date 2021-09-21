# QEMU

1.  [QEMUs two operating modes](#1-QEMUs-two-operating-modes)
    
2.  [Linux Build](#2-Linux-Build)
    
3.  [Full System Emulation Example (ARM Zynq Board)](#3-Full-System-Emulation-Example-%28ARM-Zynq-Board%29 "#3-Full-System-Emulation-Example-(ARM-Zynq-Board)")
    
4.  [User Mode Emulation Example](#4-User-Mode-Emulation-Example)
    
5.  [Bare Metal](#5-Bare-Metal)
    
6.  [Installing & using on OSX](#6-Installing-&-using-on-OSX)
    
7.  [Information](#7-Information)
    
    - QEMU Monitor
    - Differences betwen KVM, KQemu & Qemu

* * *

## 1 QEMUs two operating modes

- **Full system emulation**. In this mode, QEMU emulates a full system (for example a PC), including one or several processors and various peripherals. It can be used to launch different Operating Systems without rebooting the PC or to debug system code.
    
- **User mode emulation**. In this mode, QEMU can launch processes compiled for one CPU on another CPU. It can be used to launch the Wine Windows API emulator ([http://www.winehq.org](http://www.winehq.org/)) or to ease cross-compilation and cross-debugging.
    

**QEMU has the following features**:

- QEMU can run without a host kernel driver and yet gives acceptable performance. It uses dynamic translation to native code for reasonable speed, with support for self-modifying code and precise exceptions.
    
- It is portable to several operating systems (GNU/Linux, *BSD, Mac OS X, Windows*) and architectures.
    
- It performs accurate software emulation of the FPU.
    

**QEMU user mode emulation has the following features**:

- Generic Linux system call converter, including most ioctls.
    
- clone() emulation using native CPU clone() to use Linux scheduler for threads.
    
- Accurate signal handling by remapping host signals to target signals.
    

**QEMU full system emulation has the following features**:

- QEMU uses a full software MMU for maximum portability.
    
- QEMU can optionally use an in-kernel accelerator, like kvm. The accelerators execute most of the guest code natively, while continuing to emulate the rest of the machine.
    
- Various hardware devices can be emulated and in some cases, host devices (e.g. serial and parallel ports, USB, drives) can be used transparently by the guest Operating System. Host device passthrough can be used for talking to external physical peripherals (e.g. a webcam, modem or tape drive).
    
- Symmetric multiprocessing (SMP) support. Currently, an in-kernel accelerator is required to use more than one host CPU for emulation.
    

[https://qemu.weilnetz.de/doc/qemu-tech-20160903.html#intro\_005fx86\_005femulation](https://qemu.weilnetz.de/doc/qemu-tech-20160903.html#intro_005fx86_005femulation)

For Information on how to start QEMU with option flags:

Go to build folder qemu-aarch64-softmmu -help to show start options!

***

## 2 Linux Build

https://wiki.qemu.org/Hosts/Linux

### On Ubuntu:

`sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev`

additional (SDL needed)

- `sudo apt-get install git-email`
    
- `sudo apt-get install libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev`
    
- `sudo apt-get install libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev`
    
- `sudo apt-get install libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev`
    
- `sudo apt-get install librbd-dev librdmacm-dev`
    
- `sudo apt-get install libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev`
    
- `sudo apt-get install libvde-dev libvdeplug-dev libvte-2.90-dev libxen-dev liblzo2-dev`
    
- `sudo apt-get install valgrind xfslibs-dev`
    

newer ubuntu versions might need this:

- `sudo apt-get install libnfs-dev libiscsi-dev`

### Set up with Repo

`git clone git@github.com:qemu/qemu.git`

*Additional if we use a forked Repo to work on QEMU:*
Set upstream
`git remote add upstream git@github.com:qemu/qemu.git`

Pull new changes from github repo
`git pull upstream master`

### Build & Setup

Now Building and setting up my qemu environment with:

https://en.wikibooks.org/wiki/QEMU/Installing_QEMU

The most surefire way to get QEMU working is to #build QEMU from its source. To do so, enter the following commands in a command line environment:

1.  git clone git://git.qemu-project.org/qemu.git (The git link here is provided by the [QEMU download page](http://wiki.qemu.org/Download))
    
2.  cd qemu
    
3.  git submodule init
    
4.  git submodule update --recursive ([Credit](http://askubuntu.com/a/711267/378039) for steps 3,4 and 5)
    
5.  git submodule status --recursive
    
6.  git checkout stable-2.6 (As of writing this, the stable branch version is 2.6. Change 2.6 to the number of current stable version when you are applying these steps)
    
7.  mkdir build
    
8.  cd build
    
9.  ../configure (If you want to build QEMU only for a specific target (say, only for 32-bit x86) instead of for all targets, use ../configure --target-list=i386-softmmu instead)
    
10. make
    

- **Info TARGET:** by default it will build for all your targets like x86,x86_64,arm.powerpc etc. `/configure --target-list=i386-softmmu` this will build only for x86 target i.e you will get qemu-i386 binary only.
- Simple test: `$BUILDFOLDER/x86\_64-softmmu/qemu-system-x86\_64 -L pc-bios`
- Ändern der Buildbs um SWEB mit meinem qemu zu builden: `/home/theuema/bsc_code/qemu_build/i386-softmmu/qemu-system-i386 -m 8M -cpu qemu32 -drive file=SWEB-flat.vmdk,index=0,media=disk,format=raw -debugcon stdio -no-reboot`

QEMU is multi-platform software intended to be buildable on all modern
Linux platforms, OS-X, Win32 (via the Mingw64 toolchain) and a variety
of other UNIX targets. The simple steps to build QEMU are:
  mkdir build
  cd build
  ../configure
  make
Additional information can also be found online via the QEMU website:
http://qemu-project.org/Hosts/Linux
http://qemu-project.org/Hosts/Mac
http://qemu-project.org/Hosts/W32

*** 


## 3 Full System Emulation Example (ARM Zynq Board)

```
/working/qemu/build_arm_debug/aarch64-softmmu/qemu-system-aarch64 -net nic,netdev=net0,macaddr=52:54:00:12:34:02 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -initrd tmp/deploy/images/qemu-zynq7/core-image-minimal-qemu-zynq7-20170804100356.rootfs.cpio -nographic -serial null -serial mon:stdio  -machine xilinx-zynq-a9_enc  -m 1024 -kernel tmp/deploy/images/qemu-zynq7/uImage--4.9-xilinx-v2017.1+git0+68e6869cfb-r0-qemu-zynq7-20170725140338.bin -append 'root=/dev/ram0 rw debugshell  mem=1024M ip=192.168.7.2::192.168.7.1:255.255.255.0 console=ttyPS0,115200 earlyprintk ' -dtb tmp/deploy/images/qemu-zynq7/qemu-zynq7.dtb
```

***

## 4 User Mode Emulation Example

http://nairobi-embedded.org/qemu_usermode.html

Wir brauchen einen User target folgende USER Targets im “buildqemu-script” geadded: `aarch64-linux-user`, `arm-linux-user`

**qemu-user Options and Associated Environment Variables**
The list of options and associated environment variables can be viewed by running: `qemu-arm -h`

Among other things, these options can be used to control the behaviour of the emulator as well as modifying the environment of the target process. Usage of a few of these options will be covered here, namely:

| Option | Env Var | Description |
| --- | --- | --- |
| -L path | QEMU\_LD\_PREFIX | set the ELF interpreter prefix to path |
| -E var=value | QEMU\_SET\_ENV | sets target's environment variable |
| -r uname | QEMU_UNAME | set QEMU uname release string to uname |

An **ARM cross-toolchain** is used here to build the foreign binaries in order to demonstrate qemu-user usage on the x86 host. Details on acquiring an ARM toolchain can be found here and there.
If running an Ubuntu system1:

ARM32:
`sudo apt-get install gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf`

ARM64:
`sudo apt-get install libc6-dev-arm64-cross gcc-aarch64-linux-gnu`
https://gist.github.com/bruce30262/e0f12eddea638efe7332

*This command should install all other cross-toolchain components including binutils and eglibc for both the armel and armhf architectures.*

### Write a test program

```
#include <stdio.h>
int main(void) { return printf("Hello ARM64!\n"); }
```

- QEMU\_LD\_PREFIX
    For a dynamically linked foreign executable, the path to its dynamic linker/loader can be specified in the qemu-user commandline via the -L option or the QEMU\_LD\_PREFIX environment variable.
    For instance: `cat vipi.c`

```
#include <stdio.h>

int main(void)
{
    printf("Dunia, vipi?\n");
    return 0;
}
```

**ARM32**:
`arm-linux-gnueabi-gcc -Wall vipi.c`
/\* arm-linux-gnueabihf-gcc -Wall -o executable_name source.c // also on 32bit?

`qemu-arm -L /usr/arm-linux-gnueabi a.out`

```
Dunia, vipi?
```

**ARM64**:
`aarch64-linux-gnu-gcc -Wall -o executable_name source.c`

`qemu-aarch64 -L /usr/aarch64-linux-gnu/[path-to-binary]`

or qemu-aarch64-static if you install qemu-user-static

Where:
`ls -l /usr/arm-linux-gnueabi/lib/ld-* /usr/arm-linux-gnueabi/lib/ld-2.15.so /usr/arm-linux-gnueabi/lib/ld-linux.so.3 -> ld-2.15.so`

Alternatively,
`QEMU_LD_PREFIX=/usr/arm-linux-gnueabi qemu-arm a.out`

```
Dunia, vipi?
```

or
`export QEMU_LD_PREFIX=/usr/arm-linux-gnueabi`

$ qemu-arm a.out

```
Dunia, vipi?
```

`unset QEMU_LD_PREFIX`

**Statically Linked Build**
If performing statically linked program build of the executable, then specifying QEMU\_LD\_PREFIX is not required:
`arm-linux-gnueabi-gcc -Wall vipi.c -static`

`file a.out`

```
a.out: ELF 32-bit LSB executable, ARM, version 1 (SYSV), statically linked, for GNU/Linux 2.6.31,...
```

`qemu-arm a.out`

```
Dunia, vipi?

```

***

## 5 Bare Metal

example:
`qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin`

example debug with gdb:
`qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin`

**Compile:** `aarch64-linux-gnu-gcc -Wall -O2 -o test hello.c`

**Objdump:** `aarch64-linux-gnu-objdump -f theuema_basic_tests/test`

```
theuema_basic_tests/test:     file format elf64-littleaarch64
architecture: aarch64, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x0000000000400480
```

**Bare Metal:** `/working/qemu/build_arm_64_debug/aarch64-softmmu/qemu-system-aarch64 -M xilinx-zynq-a9_enc -nographic -m 1024 -kernel theuema_basic_tests/test`

***

## 6 Installing & using on OSX

https://github.com/psema4/pine/wiki/Installing-QEMU-on-OS-X
https://linuxwebdevelopment.com/run-debian-qemu-kvm-virtual-machine-using-ubuntu-debian/

`brew install qemu`

Now, You are able to use QEMU,But you need an image file [Here](https://people.debian.org/~aurel32/qemu/sh4/) it is an example for a SH4architecture debian image.

- Download an Image/Distribution you want!

```
cd ~/Downloads/
mv debian-9.2.1-amd64-xfce-CD-1.iso ~/debian/
```

- Create disk image (virtual hard drive)

The command we will be using is called qemu-img

With this command we will create an image file called virtualdebian.img and will give it 30G of hard drive space. You can change the name and amount of space you will give it though.

`qemu-img create -f qcow2 virtualdebian.img 30G`

- Emulate and install

*(with kernel module support \*LINUX ONLY\*)*

`kvm -hda virtualdebian.img -cdrom debian-9.2.1-amd64-xfce-CD-1.iso -m 2048 -net nic -net user -soundhw all`

*(w/o kernel module support)*

`qemu-system-x86_64  -hda virtualdebian.img -cdrom debian-9.2.1-amd64-xfce-CD-1.iso -m 2048 -net nic -net user -soundhw all`

All of the hard work has now been done. You have installed Debian in the image file. Now, from now on, all you need to do to

- run your Debian Virtual machine is to run the following command.

`kvm -soundhw all -m 2048 -hda ~/debian/virtualdebian.img`

or

`qemu-system-x86_64 -m 2048 -hda ~/debian/virtualdebian.img`

***

## 7 Information

### QEMU Monitor

Send stuff to the Operating System or even ivoke gdb Server from there..
https://en.wikibooks.org/wiki/QEMU/Monitor

### Differences betwen KVM, KQemu & Qemu

https://serverfault.com/questions/208693/difference-between-kvm-and-qemu

- **Qemu**

Qemu is a complete and standalone software of its own. You use it to emulate machines, it is very flexible and portable. Mainly it works by a special 'recompiler' that transforms binary code written for a given processor into another one (say, to run MIPS code on a PPC mac, or ARM in an x86 PC).

To emulate more than just the processor, Qemu includes a long list of peripheral emulators: disk, network, VGA, PCI, USB, serial/parallel ports, etc.

- **KQemu**

In the specific case where both source and target are the same architecture (like the common case of x86 on x86), it still has to parse the code to remove any 'privileged instructions' and replace them with context switches. To make it as efficient as possible on x86 Linux, there's a kernel module called KQemu that handles this.

Being a kernel module, KQemu is able to execute most code unchanged, replacing only the lowest-level ring0-only instructions. In that case, userspace Qemu still allocates all the RAM for the emulated machine, and loads the code. The difference is that instead of recompiling the code, it calls KQemu to scan/patch/execute it. All the peripheral hardware emulation is done in Qemu.

This is a lot faster than plain Qemu because most code is unchanged, but still has to transform ring0 code (most of the code in the VM's kernel), so performance still suffers.

- **KVM**

KVM is a couple of things: first it is a Linux kernel module—now included in mainline—that switches the processor into a new 'guest' state. The guest state has its own set of ring states, but privileged ring0 instructions fall back to the hypervisor code. Since it is a new processor mode of execution, the code doesn't have to be modified in any way.

Apart from the processor state switching, the kernel module also handles a few low-level parts of the emulation like the MMU registers (used to handle VM) and some parts of the PCI emulated hardware.

Second, KVM is a fork of the Qemu executable. Both teams work actively to keep differences at a minimum, and there are advances in reducing it. Eventually, the goal is that Qemu should work anywhere, and if a KVM kernel module is available, it could be automatically used. But for the foreseeable future, the Qemu team focuses on hardware emulation and portability, while KVM folks focus on the kernel module (sometimes moving small parts of the emulation there, if it improves performance), and interfacing with the rest of the userspace code.

The kvm-qemu executable works like normal Qemu: allocates RAM, loads the code, and instead of recompiling it, or calling KQemu, it spawns a thread (this is important). The thread calls the KVM kernel module to switch to guest mode and proceeds to execute the VM code. On a privileged instruction, it switches back to the KVM kernel module, which, if necessary, signals the Qemu thread to handle most of the hardware emulation.

One of the nice things of this architecture is that the guest code is emulated in a posix thread which you can manage with normal Linux tools. If you want a VM with 2 or 4 cores, kvm-qemu creates 2 or 4 threads, each of them calls the KVM kernel module to start executing. The concurrency—if you have enough real cores—or scheduling—if not—is managed by the normal Linux scheduler, keeping code small and surprises limited.

*Current versions of qemu (0.11 and up) has no support for kqemu anymore, focusing on kvm instead. The information below is provided for historical reasons only.*