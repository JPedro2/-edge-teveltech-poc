output "edge_server" {
    # value = [
    #     for uuid in vsphere_virtual_machine.this.*.uuid:
    #     split("-",uuid)[4]
    # ]
    value = zipmap([
        for uuid in vsphere_virtual_machine.this.*.uuid:
        split("-",uuid)[4]
    ],var.control_plane)
}

output "uuid" {
    value = [
        for uuid in vsphere_virtual_machine.this.*.uuid:
        split("-",uuid)[4]
    ]
}