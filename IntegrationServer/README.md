# WebmethodsOnOCP
Deploying Webmethods IS Agent on openshift 

# Build the base Integration Server Agent image
Instructions to build initial Integration Server docker image can be found here [1] . These were the instructions used to build the base webmethods IS Agent docker file. 

Alternately, the instructions in this link [2] could be used.

This directory has an example dockerfile called IS_Agent_Dockerfile that was generated using the build script described in [1]. If instructions in [1] are used, the docker image can be built with the following command:

<SAG installation dir>/IntegrationServer/docker/is_container.sh build -Dfile.name=IS_Agent_Dockerfile -Dimage.name=is_agent:100

If the instructions in [2] are used, the following command can be run to build the image using the webmethods installed directory as the context directory:

docker build --tag is_agent:100 -f IS_Agent_Dockerfile /opt/softwareag/

For the purposes of this example, the tag "100" will be used for all the images. This tag can be changed, just update all references to it in the instructions and dockerfiles.

[1] http://www.i8c.be/webmethods-integration-agent-aws-container-service/

[2] https://techcommunity.softwareag.com/pwiki/-/wiki/Main/Running+Integration+Server+within+a+Docker+container

# Update the docker image
If the softwareag is installed in /opt/softwareag, copy the IS_Agent_wrapper_Dockerfile to the directory. This wrapper docker file updates the file persmissions on certain folders in the container so that the container can be run in openshift as a non-root user

Change directory to the docker directory where the webmethods IntegrationServer is locally installed. For the examples in these instructions, webmethods is installed in  /opt/softwareag/
cd /opt/softwareag/IntegrationServer/docker

update the docker image:

./is_container.sh build -Dfile.name=IS_Agent_wrapper_Dockerfile -Dimage.name=is_agent:100-wrapper

or run docker build command with the webmethods installed directory as the context directory

docker build --tag is_agent:100-wrapper -f IS_Agent_wrapper_Dockerfile /opt/softwareag/

If successful this will create a docker image named is_agent with the tag 100-wrapper

test the  docker image:

docker run -d -p 5557:5555 -p 9997:9999 --name=isagent is_agent:100-wrapper /sag/profiles/IS_default/bin/sagis100 console

stop and delete the container:

docker stop isagent && docker rm isagent


# Deploy webmethods Integration Server to OCP using the template 
oc new-app  webmethods.yml --param IMAGE_TAG=100-wrapper

# Deploy webmethods Integration Server to OCP with multiple commands (not recommended)
oc run is-agent --image=is_agent:100-wrapper --command -- /sag/profiles/IS_default/bin/sagis100 console

oc patch dc/is-agent  --patch '{"spec":{"template":{"spec":{"containers": [  {"name": "is-agent",  "ports":[ {"containerPort": "5555"},{"containerPort": "9999"}]}]}}}}'

oc expose dc is-agent

oc expose service is-agent --name=5555 --port=5555

oc expose service is-agent --name=9999 --port=9999

# Test the admin consoles

Using the routes exposed 

oc get routes 

Log into the admin consoles using Administrator/manage or whatever user/pass that has been setup for the Integration Server Agent
