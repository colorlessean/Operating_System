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
Then run in QEMU by simply calling: qemu sect.bin

