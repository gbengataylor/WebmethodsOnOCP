# This Dockerfile creates a preconfigured image from the base UM image; a JMS configuration and a configuration of a new channel.

FROM um:100

MAINTAINER SoftwareAG

# Give this realm a new name, bearing in mind the caveat that this can only be set once, before UM has run
ENV REALM myjmsbroker

# Go through the various steps of a toy JMS configuration
RUN umctx jmsadmin bind connectionFactory ConnectionFactory
RUN umctx jmsadmin bind topicFactory TopicConnectionFactory
RUN umctx jmsadmin bind queueFactory QueueConnectionFactory
RUN umctx jmsadmin bind topic testtopic
RUN umctx jmsadmin bind queue testqueue

# Create a channel called TestChannel 
RUN umctx nmakechan TestChannel

# update permissions
RUN chgrp -R 0 /um_home && chmod -R g=u /um_home
