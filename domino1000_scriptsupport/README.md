Create Docker image for Domino 10 with scripted setup support
=============================================================================
The Dockerfile in this directory creates a new Docker image that is based on a previously
created Docker image klehmann/domino:10.0.0 (see directory "domino1000").

We add a start script that runs the scripted Domino server setup if there is no server.id
file yet and the required environment variables have been set (server name, ID passwords etc.).

    docker build -t klehmann/domino_scriptsupport:10.0.0 .


Create a new Domino 10 server instance
======================================
This section describes how to create a new Docker container for a new Domino server. Use the steps below for each new server instance.


Create data volume for Domino data:
-----------------------------------
The volume will contain the Domino data directory and is mounted at /local/notesdata.

    docker volume create domino10_customer_abc


Setup organisation/server name and credentials
----------------------------------------------
Edit file "env.list" and enter your server's organisation name, server name, Domino domain name, admin user data and passwords.

    ORGANISATION=MyOrg
    SERVERNAME=MyServer1
    SERVER_IDPWD=

    CERTIFIER_IDPWD=cert123

    ADMIN_FIRSTNAME=Administrator
    ADMIN_LASTNAME=MyOrg
    ADMIN_IDPWD=adm1n123

    DOMINODOMAIN=MyOrg
    DOMINOHOSTNAME=localhost

SERVER_IDPWD is optional, but recommended. DOMINOHOSTNAME should be a full qualified hostname.

Run first time server setup to create ID files and setup data directory
-----------------------------------------------------------------------
This initializes environment variables from "env.list", mounts the previously created data volume at /local/notesdata and runs the Docker container.

    docker run --rm --interactive --tty --env-file ./env.list -v domino10_customer_abc:/local/notesdata klehmann/domino_scriptsupport:10.0.0

The command runs the scripted Domino server setup. The setup initializes the data directory and creates id files with the specified names and passwords.


Extract created ID files
------------------------
Next we create a new local directory "ids" and copy the created cert/server/admin ID files from the data volume.

    mkdir -p ids && docker run --rm -v domino10_customer_abc:/local/notesdata -v "$PWD":/local/notesdata_out busybox cp -f /local/notesdata/{cert.id,server.id,admin.id} /local/notesdata_out/ids

Backup these files and use them to set up your Notes Client.

Run Domino 10 server instance
=============================

Run Docker container with mounted data and published network ports and assign a name, e.g. "domino10_abc":

    docker run -p 1352:1352 -p 80:80 -p 443:443 -p 25:25 --name domino10_abc -v domino10_customer_abc:/local/notesdata klehmann/domino_scriptsupport:10.0.0

Access Domino server console in running instance
------------------------------------------------

Start a bash on the new running container:

    docker exec domino10_abc bash

Use the live console option of Daniel Nashed's start script:

    /etc/init.d/rc_domino live

Type "close" to leave the live console and "exit" to exit bash.

Stop Domino 10 docker container
===============================

To stop the running container, it is important to set the timeout value, because the default of 10 seconds between stopping and killing the container is too short for Domino:

    docker stop --time=60 domino10_abc

Start Domino 10 docker container
================================

Use this command to start the now named Domino server container:

    docker start domino10_abc

