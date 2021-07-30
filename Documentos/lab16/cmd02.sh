LOCATION=westeurope
VERSION=$(az aks get-versions --location $LOCATION --query 'orchestrators[-1].orchestratorVersion' --output tsv); echo $VERSION
RGNAME=az400m16l01a-RG
az group create --name $RGNAME --location $LOCATION
AKSNAME='az400m16aks'$RANDOM$RANDOM
# El siguiente ECHO me da el valor de la variable AKSNAME que tengo que usar en otros scripts de comandos más adelante
echo $AKSNAME
az aks create --location $LOCATION --resource-group $RGNAME --name $AKSNAME --enable-addons monitoring --kubernetes-version $VERSION --generate-ssh-keys