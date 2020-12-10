Connect-AzAccount

# Get Azure Application Gateway
$appgw=Get-AzApplicationGateway -Name DIS-TEST -ResourceGroupName RG-DBG-EUROPE

# Stop the Azure Application Gateway
Stop-AzApplicationGateway -ApplicationGateway $appgw
 
# Start the Azure Application Gateway (optional)
#Start-AzApplicationGateway -ApplicationGateway $appgw

