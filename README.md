# WebmethodsOnOCP
Deploying Webmethods Integration Server Agent and Universal Messaging to OpenShift

These instructions were composed using webmethods 10 however, docker support for webmethods has been available since version  9.7. See https://techcommunity.softwareag.com/pwiki/-/wiki/Main/Running+Integration+Server+within+a+Docker+container

All the Dockerfiles have been modified to build off a RHEL layer 

These instructions are just a foundation to help you start. In a production deployment, further changes and configurations may be required.

There are three instructions:

--Deploying Integration Server  (see IntegrationServer directory)
--Deploying Universal Messaging (see UniversalMessaging directory)
--Deploying Universal Messaging with JMS artifacts(see UniversalMessaging/Configuration directory)

All three have a README.




Assumptions - 

These examples assume that the docker images are built on the same machine where the OpenShift cluster is running. Alternately,  the docker images can be built and then pushed to a remote Openshift cluster's or enterprise container image registry. 

