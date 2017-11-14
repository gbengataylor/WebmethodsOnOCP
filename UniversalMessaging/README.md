# Universal Messaging Deployed in OCP

http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/downloads/

# Build the docker image
You can use the docker file included in the Universal Messaging install  - 
/opt/softwareag/UniversalMessaging/server/umserver/bin/docker/image

Or Download the Universal Messaging Packaging Kit for Docker - http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/5dcdf831-941d-11e5-b74b-cd8d7ef22065/?title=Universal+Messaging+Packaging+Kit+for+Docker%C2%AE

Edit the um/image/Dockerfile to change the group and permissions before the CMD command:

    +++ #edit, change group and permissions
    +++ RUN chgrp -R 0 /um_home && chmod -R g=u /um_home
    +++# Copy the license into the location that the UM realm server expects
    +++COPY ./UniversalMessaging/server/umserver/licence.xml /um_home/server/license/licence.xml
    
or just use the Dockerfile in this directory

copy the Dockerfile to where softwareag webmethods is installed.

copy the umtcx file to the softwareag directory (You can use the github version or the file in /opt/softwareag/UniversalMessaging/server/templates/docker) 

build the docker file with the webmethods installed directory as the context directory

docker build --tag um:100 /opt/softwareag/

# Test the image

docker run -d -p 9000:9000 --name um_container um:100

# Test the realm using the enterprise manager local UI

/opt/softwareag/UniversalMessaging/java/umserver/bin/nenterprisemgr

enter the realm for the um container using the nsp://hostname:9000

You should see the named realm as defined in the Dockerfile - umserver

# Test the Universal Manager with the webmethods Integration Server

Assumes the IS agent is running

login into Integration Server Admin console at the 555 port

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

change the UM_Connection to nsp://hostname:9000

Go to Settings > Messaging > webMethods Messaging Settings

If successful, Universal Messaging should now be Enabled

# Stop the docker container

Stop and delete the running container

docker stop um_container && docker rm um_container

# Deploy in Openshift

The Universal Messaging container uses nsp:// so that external applications can access it. The openshift documentation has information on how to reach non-http endpoints -https://docs.openshift.com/container-platform/3.6/dev_guide/expose_service/index.html

These instructions employs the NodePort method

https://docs.openshift.com/container-platform/3.6/dev_guide/expose_service/expose_internal_ip_nodeport.html

# Deploy in Openshift using the pre-defined um.yml template (RECOMMENDED)

oc new-app  um.yml --param IMAGE_TAG=100

# Alternate -  Deploy in openshift without the template 

oc new-app --docker-image=um:100

oc patch svc/um --patch '{"spec":{"type":"NodePort"}}'

# Deploy in openshift and use port forwarding

TODO..

# Retrieve the node port

find the node port

 oc get svc um -o yaml | grep nodePort
 
or 

Check the Service->um in the web console for the node port

# Test the realm using the enterprise manager local UI

/opt/softwareag/UniversalMessaging/java/umserver/bin/nenterprisemgr

enter the realm for the um container using the nsp://hostname:nodePort output

You should see the named realm as defined in the Dockerfile - umserver

# Test the connection using the IS Agent

login into Integration Server Admin console

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

change the UM_Connection to 
nsp://hostname:nodePort output



