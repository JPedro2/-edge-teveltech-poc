function Get-UUID {
    param (
        $VM
    )
  
    foreach ($VMName in $VM) {
      $ID=((Get-CimInstance -Namespace Root\Virtualization\V2 -ClassName Msvm_VirtualSystemSettingData -Filter "ElementName = '$VMName'").BiosGUID).split("-")[4]
      Write-Output "${VMName}: ${ID}"
    }
  } 
  