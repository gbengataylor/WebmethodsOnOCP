# Universal Messaging Deployed in OCP

http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/universal-messaging/downloads/

# Build the docker image
Download the Universal Messaging Packaging Kit for Docker - http://techcommunity.softwareag.com/ecosystem/communities/public/apama/products/apama/.links/universal-messaging-docker

Edit the um/image/Dockerfile to change the group and permissions before the CMD command:

    +++ #edit, change group and permissions
    +++ RUN chgrp -R 0 /um_home && chmod -R g=u /um_home
    
or just use the Dockerfile in this directory

copy the Dockerfile to where softwareag webmethods is installed.

copy the umtcx file to the softwareag directory

in the softwareag directory, build the docker file

docker build --tag um:100 .

Test the image

docker run -d -p 9000:9000 --name um_container um:100

Stop and delete the running container

docker stop um_container && docker rm um_container

# Deploy in Openshift using the um.yml template
oc new-app  um.yml --param IMAGE_TAG=100

# Deploy in openshift without the template 

oc new-app --docker-image=um:100

oc expose service um




