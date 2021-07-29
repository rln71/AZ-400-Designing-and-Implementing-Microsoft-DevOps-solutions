SQLDB_SRV_NAME='az400m15sqlsrv2507712797.database.windows.net'
SQLDB_NAME='az400m15sqldb'
WEB_APP_NAME='az400m151web208042268'
RG_NAME='az400m1501a-RG'
CONNECTION_STRING="Data Source=tcp:$SQLDB_SRV_NAME.database.windows.net,1433;Initial Catalog=$SQLDB_NAME;User Id=sqladmin;Password=Pa55w.rd1234;"
az webapp config connection-string set --name $WEB_APP_NAME --resource-group $RG_NAME --connection-string-type SQLAzure --settings defaultConnection="$CONNECTION_STRING"