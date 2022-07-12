  
param(
	[parameter(Mandatory = $true)]
	[string]$CSVname
	)

#Getting VMS from .csv
 $VMs = Import-CSV $CSVname -Header "guestName"

#Loop to Provision VMs

 ForEach($VM in $VMs){

#Deploy the VM
	New-VM -Name $VM.guestName -Template sb-opensuse-k3s-1.21.12 -Datastore vsanDatastore3 -ResourcePool(Get-ResourcePool -name RP_Justin -Location(Get-Cluster "Cluster3"))

#PowerOn VM
	Get-VM $VM.guestName | Start-VM	

}
 
 Foreach ($VM in $VMs) {
    $ID=Get-VM $VM.guestName | %{(Get-View $_.Id).config.uuid}
    $ID.split("-")[4]
  } 
