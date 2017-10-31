# Universal Messaging Deployed in OCP

http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/downloads/

# Build the docker image
Download the Universal Messaging Packaging Kit for Docker - http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/5dcdf831-941d-11e5-b74b-cd8d7ef22065/?title=Universal+Messaging+Packaging+Kit+for+Docker%C2%AE

Edit the um/image/Dockerfile to change the group and permissions before the CMD command:

    +++ #edit, change group and permissions
    +++ RUN chgrp -R 0 /um_home && chmod -R g=u /um_home
    +++# Copy the license into the location that the UM realm server expects
    +++COPY ./UniversalMessaging/server/umserver/licence.xml /um_home/server/license/licence.xml
    
or just use the Dockerfile in this directory

copy the Dockerfile to where softwareag webmethods is installed.

copy the umtcx file to the softwareag directory

in the softwareag directory, build the docker file

docker build --tag um:100 .

Test the image

docker run -d -p 9000:9000 --name um_container um:100

Stop and delete the running container

docker stop um_container && docker rm um_container

# Test the Universal Manager with the webmethods Integration Server

Assumes the IS agent is running

login into Integration Server Admin console at the 555 port

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

change the UM_Connection to nsp://hostname:9000

Go to Settings > Messaging > webMethods Messaging Settings

If successful, Universal Messaging should now be Enabled

# Deploy in Openshift using the um.yml template

oc new-app  um.yml --param IMAGE_TAG=100

# Deploy in openshift without the template 

oc new-app --docker-image=um:100

oc patch svc/um --patch '{"spec":{"type":"NodePort"}}'

# Deploy in openshift and use port forwarding

TODO..

# Test

find the node port

 oc get svc yn -o yaml | grep nodePort
or 

Check the Service->um in the web console for the node port

login into Integration Server Admin console

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

change the UM_Connection to 
nsp://hostname:nodePort output



