One time setup: Create Docker image for Domino 10 with scripted setup support
=============================================================================
The Dockerfile in this directory creates a new Docker image that is based on a previously
created Docker image klehmann/domino:10.0.0 

We add a start script that runs the scripted Domino server setup if there is no server.id
file yet and the required environment variables have been set (server name, ID passwords etc.).

    docker build -t klehmann/domino_scriptsupport:10.0.0 .


Create a new Domino 10 server instance
======================================
This section describes how to create a new Docker container for a new Domino server. 


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
Next we create a new local directory "ids" and extract the created cert/server/admin ID files from the data volume.

    mkdir -p ids && docker run --rm -v domino10_customer_abc:/local/notesdata -v "$PWD":/local/notesdata_out busybox cp -f /local/notesdata/{cert.id,server.id,admin.id} /local/notesdata_out/ids


Run Domino 10 server instance
=============================

Run Docker container with mounted data and published network ports in interactive mode:

    docker run --rm --interactive --tty -p 1352:1352 -p 80:80 -p 443:443 -p 25:25  -v domino10_customer_abc:/local/notesdata klehmann/domino_scriptsupport:10.0.0


