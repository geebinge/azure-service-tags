
# Introduction

This scrips this script download the Azure Service Tags (IP Addressed of the Azure Services), and enable for a specific service in a Azure Region the IP's for a functionapp 
This is helpful, if you want to restrict the access to you azure functions only from e.g. the IoT Hub's from a sprecial region 


## Installation

if azure cli is not installed use

```
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bashgit clone https://github.com/geebinge/create-iso3166-table
```

to install the sccipts use

```
git clone https://github.com/geebinge/azure-service-tags
cd ./azure-service-tags
chmod 775 azure_service_tags.sh
```

Edit all varibles in azure_service_tags.sh

```
./azure_service_tags.sh 
```

After you start the script you will get asked to use a web browser to open the page https://microsoft.com/devicelogin and enter the code you get asked to authenticate.
