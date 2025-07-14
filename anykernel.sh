# AnyKernel3 Ramdisk Mod Script – Axira+ Signature Edition
# osm0sis @ xda-developers | modded by Copilot & Irfan

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Axira+ vNext for Begonia
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=1
device.name1=begonia
device.name2=begoniain
supported.versions=
supported.patchlevels=
'; } # end properties

# ROM Detection Logic
isTimRom() {
  build_prop="/system/build.prop"
  version_prop="ro.crdroid.build.version"
  grep -q "$version_prop" "$build_prop" && grep -q "timjosten" "$build_prop"
}

isDerp() {
  build_prop="/system/build.prop"
  version_prop="ro.derp.fingerprint"
  grep -q "$version_prop" "$build_prop" && grep -q "DerpFest" "$build_prop"
}

# Block Setup
block=/dev/block/bootdevice/by-name/boot;

# Flashing Logic Starts
if isTimRom; then
    block=boot;
    is_slot_device=auto;
    ramdisk_compression=none;

    . tools/ak3-core.sh;

    ui_print "╭──────────────────────────────╮"
    ui_print "│  🎯 ROM: Tim's Signature Detected   │"
    ui_print "│  🔧 Axira+ Kernel Deployment       │"
    ui_print "╰──────────────────────────────╯"
    ui_print "» Vibration Layer Optimization »"
    ui_print "» Welcome to Axira+ — Precision Begins »"

    split_boot;
    patch_cmdline initcall_blacklist initcall_blacklist=
    flash_boot;

elif isDerp; then
    block=/dev/block/by-name/boot;
    is_slot_device=0;
    ramdisk_compression=auto;
    no_block_display=true;

    . tools/ak3-core.sh;

    mount -o rw,remount -t auto /vendor >/dev/null;
    restore_file /vendor/etc/init/hw/init.target.rc;

    rm -rf $ramdisk/overlay;
    rm -rf $ramdisk/overlay.d;

    ui_print "╭──────────────────────────────╮"
    ui_print "│  🎯 ROM: DerpFest Detected          │"
    ui_print "│  🔧 Axira+ Kernel Deployment       │"
    ui_print "╰──────────────────────────────╯"
    ui_print "» Welcome to Axira+ — Elegance Loaded »"

    dump_boot;
    write_boot;

else
    is_slot_device=0;
    ramdisk_compression=auto;
    no_block_display=true;

    . tools/ak3-core.sh;

    mount -o rw,remount -t auto /vendor >/dev/null;
    restore_file /vendor/etc/init/hw/init.target.rc;

    rm -rf $ramdisk/overlay;
    rm -rf $ramdisk/overlay.d;

    ui_print "╭──────────────────────────────╮"
    ui_print "│  📦 Generic ROM Detected             │"
    ui_print "│  🔧 Axira+ Kernel Deployment       │"
    ui_print "╰──────────────────────────────╯"
    ui_print "» Executing kernel transition... »"

    dump_boot;
    write_boot;

fi
