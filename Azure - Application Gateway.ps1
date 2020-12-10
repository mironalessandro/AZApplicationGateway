Connect-AzAccount

# Get Azure Application Gateway
$appgw=Get-AzApplicationGateway -Name AGNAME -ResourceGroupName RESOURCEGROUPNAME

# Stop the Azure Application Gateway
Stop-AzApplicationGateway -ApplicationGateway $appgw
 
# Start the Azure Application Gateway (optional)
#Start-AzApplicationGateway -ApplicationGateway $appgw

