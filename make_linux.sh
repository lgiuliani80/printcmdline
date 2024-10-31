#!/bin/sh

as -o printcmdlinelinux.o printcmdlinelinux.s
ld -o printcmdlinelinux printcmdlinelinux.o
