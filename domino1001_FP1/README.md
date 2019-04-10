Download Domino 10.0.1 FP1 installation archive
===========================================================

Domino 10.0.1 FP1 installation archive is expected to be downloaded to "resources/domino10installer" and named "domino10001FP1_linux64.tar".

The file is not included in this repository for licensing reasons.


Create Docker image for Domino 10.0.1 FP1
=============================================================================
The Dockerfile in this directory creates a new Docker image klehmann/domino:10.0.1.FP1 based on "klehmann/domino:10.0.1" and installs Domino 10.0.1 FP1.

    docker build -t klehmann/domino:10.0.1.FP1 .

Starting new Docker containers with this image runs the server in listen mode for remote server setup on port 1352.

Next steps
============

