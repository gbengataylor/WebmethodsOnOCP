# WebmethodsOnOCP
Deploying Webmethods IS Agent on openshift 

Instructions to build initial Integration Server docker image can be found here - http://www.i8c.be/webmethods-integration-agent-aws-container-service/ . These were the instructions used to build the base webmethods IS Agent docker file. Alternately, the instructions in this link could be used - https://techcommunity.softwareag.com/pwiki/-/wiki/Main/Running+Integration+Server+within+a+Docker+container

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
