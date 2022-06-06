function Create-EdgeVm {
    param (
        $VM
    )
  
    foreach ($VMName in $VM) {
      $name = "${VMNAME}"
      $cpu_count = 4
      $ram_gb = 8
      $hdd1_gb = 120
      $hdd2_gb = 60
      $dvd = 'D:\Software\Palette\saad-original\p6os-1.21.12-2.iso'
  
      $VM = New-VM -Name $name -MemoryStartupBytes ($ram_gb * 1GB)  -BootDevice VHD -NewVHDPath "V:\Virtual Hard Disks\$name.vhdx" -NewVHDSizeBytes ($hdd1_gb * 1Gb) -Generation 2 -Switch 'Dreamworx Internal Virtual Switch'
      $VM | Set-VMProcessor -Count $cpu_count
      $VM | Set-VMFirmware -EnableSecureBoot Off
      $DVD = $VM | Add-VMDvdDrive -Path $dvd -Passthru
      $VM | Set-VMFirmware -FirstBootDevice $DVD
  
      New-VHD -Path "V:\Virtual Hard Disks\$name-DATA.vhdx" -SizeBytes ($hdd2_gb * 1Gb) -Dynamic
      $VM | Add-VMHardDiskDrive -ControllerType SCSI -ControllerNumber 0 -ControllerLocation 2 -Path "V:\Virtual Hard Disks\$name-DATA.vhdx"
  
      $VM | Start-VM
      $VM | Format-List Name, Generation, State, ProcessorCount, MemoryStartup, MemoryStatus, HardDrives, Uptime, Status
    }
  }
   
  