# Universal Messaging Deployed in OCP

http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/downloads/

Download the Universal Messaging Packaging Kit for Docker - http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/apama/.links/universal-messaging-docker

Edit the file to change the group and permissions or just use the Dockerfile in this directory

copy the Dockerfile to where softwareag webmethods is installed. Assume it is installed in /opt/softwareag/

copy the umtcx file to the softwareag directory

in the softwareag directory, build the docker file

docker build --tag um:100 .

To 


