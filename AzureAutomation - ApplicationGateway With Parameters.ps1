###################################################################################
# You can use this script if you want to start and stop da AG based on a VM status#
# Parameters to change                                                            #
# Row 38 AGNAME and AGRESOURCEGROUPNAME                                           #
# Row 39 VM NAME                                                                  #
# https://github.com/mironalessandro/AZApplicationGateway                         #
################################################################################### 




$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "

    $servicePrincipalConnection = Get-AutomationConnection -Name $connectionName

    "Logging in to Azure..."
    $connectionResult =  Connect-AzAccount -Tenant $servicePrincipalConnection.TenantID `
                             -ApplicationId $servicePrincipalConnection.ApplicationID   `
                             -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint `
                             -ServicePrincipal
    "Logged in."

}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}
# Get Azure Application Gateway
$appgw=Get-AzApplicationGateway -Name APPLICATIONGATEWAYNAME -ResourceGroupName RESOURCEGROUPNAME
$vm = Get-AzVM -Name AZEUDISAS01 -Status
if($vm.PowerState -eq "VM deallocated")
{
    if($appgw.OperationalState -ne "Stopped")
    {
        "Application Gateway started with VM deallocated. Stopping it..."
        Stop-AzApplicationGateway -ApplicationGateway $appgw
        "Stopped"
    }    
}
if($vm.PowerState -eq "VM running")
{
    if($appgw.OperationalState -eq "Stopped")
    {
        "Application Gateway stopped with VM Running. Starting it..."
        Start-AzApplicationGateway -ApplicationGateway $appgw
        "Started"
    }    
}
if($vm.PowerState -eq "VM running")
{
    if($appgw.OperationalState -eq "Running")
    {
        "Everything OK. Vm is running and Application Gateway is started"
        "Nothing to do."
    }    
}
