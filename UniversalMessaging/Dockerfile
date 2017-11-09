# Copyright (c) 2015 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
# Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG
#
# $Date: 2015-07-20 18:16:17 +0100 (Mon, 20 Jul 2015) $
# $Revision: 259887 $
#
# This Dockerfile creates an image that can run a fully-functional UM realm
# server, and the standard realm server client tools. It is built from an
# existing UM installation. The build should be run from the root of your UM
# installation e.g. /opt/SoftwareAG/UniversalMessaging/

# Pull RHEL base image from the Docker Hub - this is the latest supported
# operating system for this version of UM.
#modified from centos:7
FROM rhel:latest

MAINTAINER SoftwareAG

# Copy the minimum contents from the installation necessary to run a fully-functional realm server and the client tools
COPY ./UniversalMessaging/server/umserver/ /um_home/server/umserver/
COPY ./UniversalMessaging/lib/ /um_home/lib/
COPY ./UniversalMessaging/classes/ /um_home/classes/
COPY ./UniversalMessaging/java/umserver/ /um_home/java/umserver/
COPY ./UniversalMessaging/javascript/lib/ /um_home/javascript/lib/
COPY ./jvm/jvm/ /java_home/

# Copy in the 'umctx' wrapper script to facilitate launching the realm server and using client tools
COPY ./umctx /um_home/umctx/umctx

# Path gives access to 'umctx' and 'java', classpath gives access to all UM libraries
ENV PATH=/bin:/usr/bin:/um_home/umctx/:/java_home/bin/\
    CLASSPATH=lib/*:classes/

# Redirect plugin logs to the same place as the realm logs (i.e. stdout, to be captured by Docker's logging system)
# This is included for the benefit of having complete logging via Docker, but you may prefer to remove this line if you want the plugin logs
# segregated in separate files, rather than interleaved with the main realm server log
RUN cd /um_home/server/umserver/; mkdir -p plugins/log/; cd plugins/log/; rm -f *; ln -s /dev/stdout error.log; ln -s /dev/stdout plugin.log; ln -s /dev/stdout access.log

# Remove state from the the installation to give you a 'clean slate' w.r.t licensing, keys, configuration and state
#RUN rm -f `find /um_home/ -name *.jks`; rm -rf /um_home/server/license/; rm -rf /um_home/server/umserver/data/
#leaving license in
RUN rm -f `find /um_home/ -name *.jks`; rm -rf /um_home/server/umserver/data/

# Default realm name, can be customised by changing this line, or overriding this variable when running the image for the first time. After
# the image has been run once it is too late to change the realm name in subsequent derived images, as it gets baked into persistent
# configuration.
ENV REALM umserver

# Extra properties to pass to the realm server, intended for settings that can only be configured at realm server startup. The default here
# is to ask it to start it without using low-latency mode (CORE_SPIN), but this environment variable can be overridden when running the image.
ENV SERVER_OPTS_EXTRA -DCORE_SPIN=false

# Expose the NSP/NHP port that the realm server starts an interface for by default
EXPOSE 9000

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR /um_home/

#edit, change group and permissions
RUN chgrp -R 0 /um_home && chmod -R g=u /um_home

# Copy the license into the location that the UM realm server expects
COPY ./UniversalMessaging/server/umserver/licence.xml /um_home/server/license/licence.xml

# The default operation for the image is to start a realm server
# You probably have no need to override this
CMD ["umctx", "nserver"]
