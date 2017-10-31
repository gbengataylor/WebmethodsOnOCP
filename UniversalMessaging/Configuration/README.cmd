# Universal Messaging configured with JMS queue and channgel Deployed in OCP

Pre-requisite - make sure um image has been built

# Build the docker image
docker build --tag um_configured:100 .

Test the image

docker run -d -p 9000:9000 --name um_configured_container um_configured:100


# Test the Universal Manager with the webmethods Integration Server

Assumes the IS agent is running

login into Integration Server Admin console at the 5555 port

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

Add a new UM_Connection to nsp://hostname:9000

Go to Settings > Messaging > webMethods Messaging Settings

If successful, Universal Messaging should now be Enabled

Stop and delete the running container

docker stop um_configured_container && docker rm um_configured_container

# Deploy in Openshift using the um_configured.yml template

oc new-app  um_configured.yml --param IMAGE_TAG=100

# Deploy in openshift without the template 

oc new-app --docker-image=um_configured:100

oc patch svc/um-configured --patch '{"spec":{"type":"NodePort"}}'

# Deploy in openshift and use port forwarding

TODO..

# Test

find the node port

 oc get svc um-configured -o yaml | grep nodePort
or 

Check the Service->um-configured in the web console for the node port

login into Integration Server Admin console

Settings > Messaging > webMethods Messaging Settings > Universal Messaging Connection Alias

Add a new UM_Connection and set the realm to
nsp://hostname:nodePort output


TODO: Show the JMS queue and channel
