# Repo that contains Operating System / Kernel Development and Learning

## Legend

Lessons folder includes all of the files that were used to learn about different components of building 
bootsector code and a kernel

The src folder is what contains the actual kernel that is being built up with the lessons learned from 
the various sources referened on the OS dev wiki

## Goal

The goal of this project is to understand the fundamentals of building x86 operating systems and hopefully 
can be used as reference for others on how to build up a kernel of their own

## How to Run

All of the projects are meant to be run in QEMU
Each project should be compiled using the command style: nasm boot sect.asm -f bin -o boot sect.bin 
Then run in QEMU by simply calling: qemu-system-x86_64 sect.bin

## Setup Build Tools (Not True maybe)

To install binutils
* mkdir /tmp/src
* cd /tmp/src
* curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz # If the link 404's, look for a more recent *version
* tar xf binutils-2.24.tar.gz
* mkdir binutils-build
* cd binutils-build
* ../binutils-2.24/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls *--disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
* make all install 2>&1 | tee make.log

To install gcc toolchain
* cd /tmp/src
* curl -O https://ftp.gnu.org/gnu/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2
* tar xf gcc-4.9.1.tar.bz2
* mkdir gcc-build
* cd gcc-build
* ../gcc-4.9.1/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp *--enable-languages=c --without-headers
* make all-gcc 
* make all-target-libgcc 
* make install-gcc 
* make install-target-libgcc