# Copyright (c) 2015 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
# Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG
#
# $Date: 2015-07-15 20:01:27 +0300 (Wed, 15 Jul 2015) $
# $Revision: 259622 $

TradeSpace demo
===============
This sample demonstrates how to configure and build a complete containerised
application consisting of a UM realm server configured to serve content and
messages over HTTP, and two UM client applications that publish messages to
it. It is based on the UM 'TradeSpace' demo. It uses Docker Compose,
configured via 'docker-compose.yml' in this directory.

This sample makes following assumptions:

	That you have already created the base Universal Messaging image from the
	Dockerfile in 'images/', with the name 'um'.

	Internet access to 'https://showcase.um.softwareag.com' is available. If
	not, the newsfeed part of the TradeSpace demo may not operate correctly.

	You have copied the contents of the Tradespace demo ('demo/' from your UM
	installation) into this directory.
	
Use docker-compose to run the sample:

	> docker-compose up -d

Compose will then launch 3 new containers - one UM realm server, and two data
publishers for FXNews and FXRates.

You can then browse to 'http://<hostname>:8080', where '<hostname>' is the
host running Docker to see the demo running. Only the 'JavaScript' mode is
supported here.
