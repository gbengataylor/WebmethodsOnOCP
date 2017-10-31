# Copyright (c) 2015 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
# Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG
#
# $Date: 2015-07-15 19:03:09 +0300 (Wed, 15 Jul 2015) $
# $Revision: 259613 $
#
# This Dockerfile creates an image from the UM base image, adding in the Java classes for the TradeSpace publisher applications

FROM um
MAINTAINER SoftwareAG
COPY ./demo/classes/ /um_home/classes
