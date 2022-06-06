## PowerShell Scrips

This folder contains Powershell scripts for deploying the edge vms into differente environments.  For vmware, a template needs to be created (if you want to have nested virtualization this will need to be enabled).

For Hyper-V, this script creates the vms attaching the ISO from a location on disk.

The Vmware script provides an output of the UUIDs which can be used to pre-provision in Palette.

The Hyper-V script is a separate action included in this folder.