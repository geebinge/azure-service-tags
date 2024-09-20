#!/bin/bash 
# this script download the Azure Service Tags, and enable for a specific service in a Azure Region the IP's for a functionapp 
 
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
. ${SCRIPT_DIR}/az_cli.sh


#Edit this set of environment varibales 
export ResourceGroup="" 
export AZ_Tenant="" 
export AppName=""  #Name of the funcation app 
export ServiceTag="AzureIoTHub.WestEurope" # e.g. if you like to enable the IoT Hubs in West Europe

az_login ${AZ_Tenant}

export ON="N"
export i=1 
export STURL=`curl https://www.microsoft.com/en-us/download/confirmation.aspx?id=56519 2>/dev/null  | grep url=https://download.microsoft.com/ | grep ServiceTags_Public_  | sed 's/url=/\n/g' | sed 's/.json/.json\n/g' | tail -2 | head -1`
wget -cq $STURL -O - | sed 's/\( \|"\|,\|\r$\)//g' | while read line 
do 
	#echo "${ON}:${ServiceTag}:${line}:" 
	[ "${line}" == "name:${ServiceTag}" ] && ON="Y"
	[ "${line}" == "]" ] && ON="N"
	if [ "${ON}" == "Y" ]
	then 
		echo "${line}" 
	fi 
done | sed 's/\( \|"\|\r$\)//g' | while read line 
do 
	if [ "${ON}" == "Y" ]
	then 
		echo "${line}" 
	fi 
	[ "${line}" == "addressPrefixes:[" ] && ON="Y"
done | while read ip 
do 
	az functionapp config access-restriction add -g ${ResourceGroup} -n ${AppName} --rule-name ${ServiceTag}_${i} --action Allow --ip-address ${ip} --priority 200
	export i=$((i+1))
done 
