# WebmethodsOnOCP
Deploying Webmethods Integration Server Agent and Universal Messaging to OpenShift

These instructions were composed using webmethods 10 however, docker support for webmethods has been available since version  9.7. See https://techcommunity.softwareag.com/pwiki/-/wiki/Main/Running+Integration+Server+within+a+Docker+container

Assumptions - 

These instructs assume that the docker images are built on the same machine where the OpenShift cluster is running. Alternately,  the docker images can be built and then push to a remote Openshift cluster's container image registry. 

