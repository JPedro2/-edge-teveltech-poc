  
param(
	[parameter(Mandatory = $true)]
	[string]$CSVname
	)

#Getting VMS from .csv
 $VMs = Import-CSV $CSVname -Header "guestName"

#Loop to Provision VMs

 ForEach($VM in $VMs){

#Deploy the VM
	New-VM -Name $VM.guestName -Template p3os-temp -Datastore Mjolnir -ResourcePool edge -Location edge

#PowerOn VM
	Get-VM $VM.guestName | Start-VM	

}
 
 Foreach ($VM in $VMs) {
    $ID=Get-VM $VM.guestName | %{(Get-View $_.Id).config.uuid}
    $ID.split("-")[4]
  } 
