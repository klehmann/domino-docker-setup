This repository contains Docker files and resources to create Domino 10 docker images with/without automatic server setup.

domino1000
==========
Dockerfile to create a Docker image with installed Domino 10. This server starts in remote server setup listen mode on port 1352
when no server.id can be found.


domino1000_scriptsupport
========================
This Dockerfile extends the previous Docker image and provides support for scripted Domino 10 server setup. This means it
runs the server setup with server/certifier/admin name and credentail information provided via environment variables.

