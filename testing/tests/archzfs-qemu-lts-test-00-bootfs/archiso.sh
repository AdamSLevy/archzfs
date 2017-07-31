#
# Used to configure custom built archiso
#

# We need an archiso with the lts kernel used by default
test_build_archiso() {
    msg "Building archiso"
    cd ${test_root_dir}/../../../archiso/ &> /dev/null
    if [[ -d ${vm_work_dir}/out ]] && [[ $(ls -1 | wc -l) -gt 0 ]]; then
        run_cmd_no_dry_run "rm -rf ${test_root_dir}/archiso/out/archlinux*"
    fi
    run_cmd_no_dry_run "./build.sh -v"
    msg2 "Copying archiso to vm_work_dir"
    run_cmd_no_dry_run "cp ${test_root_dir}/../../../archiso/out/archlinux* ${vm_work_dir} && rm -rf ${test_root_dir}/archiso/work"
    cd - &> /dev/null
}
