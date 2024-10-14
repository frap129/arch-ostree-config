#!/usr/bin/env bash
# Copyright (C) 2023-2024 Vladislav Nepogodin
#
# This file is part of CachyOS chwd.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

kernels="$(pacman -Qqs "^linux-cachyos")"
packages=""

for kernel in $kernels; do
    case "$kernel" in
        *-nvidia-open) modules+=" ${kernel}";;
        *-headers|*-zfs|*-nvidia|*-dbg);;
        *) packages+=" ${kernel}-nvidia-open";;
    esac
done

# Fallback if there are no kernels with pre-built modules
[ -z "$packages" ] && packages="nvidia-open-dkms"

echo "$packages"
