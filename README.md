# Domino Docker Setup
This repository contains Dockerfiles and resources to create Domino 10 docker images in both interactive and non-interactive ways (remote server setup via Domino Administrator vs. a pure commandline based setup).

To set up the Docker images on your machine, please follow the installation steps in the following directories:

## domino1000
Dockerfile to create a Docker image with installed Domino 10. This server starts in remote server setup listen mode on port 1352
when no server.id can be found.

## domino1000_scriptsupport
This Dockerfile extends the previous Docker image and provides support for scripted Domino 10 server setup. This means it
runs the server setup with server/certifier/admin name and credential information provided via environment variables.


## domino1001
Dockerfile to create a Docker image with installed Domino 10.0.1. This server starts in remote server setup listen mode on port 1352
when no server.id can be found.

## domino1001_scriptsupport
This Dockerfile extends the previous Docker image and provides support for scripted Domino 10.0.1 server setup. This means it
runs the server setup with server/certifier/admin name and credential information provided via environment variables.


# Licence
The code is available under Apache 2.0 license.

Copyright by [Mindoo GmbH](http://www.mindoo.com)

# Todos
* use best practices described in this article: ["IBM Domino support for running Domino on Docker"](http://www-01.ibm.com/support/docview.wss?uid=swg22013200)
* reduce Docker image size by leveraging [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)
* work on additional server installations in a Domino Domain
* add image to install AppDev pack

# References
The provided Dockerfiles for Domino have been inspired by Ulrich Krause's great blog article ["Domino on Docker"](https://www.eknori.de/2017-08-20/domino-on-docker/).

