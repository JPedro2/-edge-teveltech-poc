output "uuid" {
    value = [
        for uuid in vsphere_virtual_machine.this.*.uuid:
        split("-",uuid)[4]
    ]
}