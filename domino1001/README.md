Download Domino 10.0.1 installation archive
===========================================

Domino 10.0.1 installation archive is expected to be downloaded to "resources/domino_installer" and named "DOM_SVR_V10.0.1_64_BIT_Lnx.tar".

The file is not included in this repository for licensing reasons.


Create Docker image for Domino 10.0.1
=============================================================================
The Dockerfile in this directory creates a new Docker image klehmann/domino:10.0.1 based on "centos" and installs Domino 10.0.1

    docker build -t klehmann/domino:10.0.1 .

Starting new Docker containers with this image runs the server in listen mode for remote server setup on port 1352.

Next steps
============
Go to directory "domino1001_scriptsupport" and extend this Docker image to run the first server setup from the command line.
