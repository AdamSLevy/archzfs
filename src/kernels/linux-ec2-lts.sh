# For build.sh
mode_name="ec2-lts"
package_base="linux-ec2-lts"
mode_desc="Select and use the packages for the linux-ec2-lts kernel"

# pkgrel for LTS packages
pkgrel="1"

# pkgrel for GIT packages
pkgrel_git="1"
zfs_git_commit=""
zfs_git_url="https://github.com/zfsonlinux/zfs.git"

header="\
# Maintainer: Jan Houben <jan@nexttrex.de>
# Contributor: Jesus Alvarez <jeezusjr at gmail dot com>
#
# This PKGBUILD was generated by the archzfs build scripts located at
#
# http://github.com/archzfs/archzfs
#
# ! WARNING !
#
# The archzfs packages are kernel modules, so these PKGBUILDS will only work with the kernel package they target. In this
# case, the archzfs-linux-ec2-lts packages will only work with the default linux-ec2-lts package! To have a single PKGBUILD target
# many kernels would make for a cluttered PKGBUILD!
#
# If you have a custom kernel, you will need to change things in the PKGBUILDS. If you would like to have AUR or archzfs repo
# packages for your favorite kernel package built using the archzfs build tools, submit a request in the Issue tracker on the
# archzfs github page.
#"

get_kernel_options() {
    msg "Checking Uplink Labs ec2 repo for the latest linux kernel version..."
    if ! get_git_repo_package "linux-ec2-lts"; then
        exit 1
    fi
    kernel_version="$git_repo_output"
    kernel_version_full=$(kernel_version_full ${kernel_version})
    kernel_version_pkgver=$(kernel_version_no_hyphen ${kernel_version})
    kernel_version_major=${kernel_version%-*}
    kernel_mod_path="${kernel_version_full}-ec2-lts"
    linux_depends="\"linux-ec2-lts=\${_kernelver}\""
    linux_headers_depends="\"linux-ec2-lts-headers=\${_kernelver}\""
}

update_linux_ec2_lts_pkgbuilds() {
    get_kernel_options
    pkg_list=("zfs-linux-ec2-lts")
    archzfs_package_group="archzfs-linux-ec2-lts"
    zfs_pkgver=${zol_version}
    zfs_pkgrel=${pkgrel}
    zfs_conflicts="'zfs-linux-ec2-lts-git' 'zfs-linux-ec2-lts-rc' 'spl-linux-ec2-lts'"
    zfs_pkgname="zfs-linux-ec2-lts"
    zfs_utils_pkgname="zfs-utils=\${_zfsver}"
    # Paths are relative to build.sh
    zfs_pkgbuild_path="packages/${kernel_name}/${zfs_pkgname}"
    zfs_src_target="https://github.com/zfsonlinux/zfs/releases/download/zfs-\${_zfsver}/zfs-\${_zfsver}.tar.gz"
    zfs_workdir="\${srcdir}/zfs-\${_zfsver}"
    zfs_replaces='replaces=("spl-linux-lts")'
}