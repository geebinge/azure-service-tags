#!/bin/bash 
# for az login and open storage ip in case it is closed 


az_login () {

	export AZ_Tenant=$1 
	az ad signed-in-user show > /dev/null
	export RC=$?

	while [ "$RC" -gt 0 ] 
	do 
		az login --use-device-code --tenant  "${AZ_Tenant}"  > /dev/null 
		az ad signed-in-user show > /dev/null
		export RC=$?
	done 
} 