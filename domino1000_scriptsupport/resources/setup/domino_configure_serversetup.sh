#!/bin/bash

if [ ! -f "/local/notesdata/names.nsf" ]; then
    if [ ! "$SERVERNAME" = "" ] && [ ! "$ORGANISATION" = "" ] && [ ! "$CERTIFIER_IDPWD" = "" ] && [ ! "$ADMIN_FIRSTNAME" = "" ] && [ ! "$ADMIN_LASTNAME" = "" ] && [ ! "$ADMIN_IDPWD" = "" ] && [ ! "$DOMINODOMAIN" = "" ] && [ ! "$DOMINOHOSTNAME" = "" ]
    then
        # configure setup profile and run silent server setup
        echo Copying silent setup profile...
        cp -f /setup.pds /tmp/setup_customized.pds
    
        echo Customizing setup profile...
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -ServerName $SERVERNAME /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -OrganizationName $ORGANISATION /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -OrganizationPassword $CERTIFIER_IDPWD /tmp/setup_customized.pds
    
        if [ ! "$SERVER_IDPWD" = "" ]
        then
            /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -ServerPassword $SERVER_IDPWD /tmp/setup_customized.pds
        fi
    
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -AdminFirstName $ADMIN_FIRSTNAME /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -AdminLastName $ADMIN_LASTNAME /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -AdminPassword $ADMIN_IDPWD /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -DominoDomainName $DOMINODOMAIN /tmp/setup_customized.pds
        /opt/ibm/domino/notes/latest/linux/java -cp /opt/ibm/domino/notes/latest/linux/cfgdomserver.jar lotus.domino.setup.DominoServerProfileEdit -HostName $DOMINOHOSTNAME /tmp/setup_customized.pds
    
        echo Running silent server setup...
        su - notes -c "cd /local/notesdata; /opt/ibm/domino/bin/server -pb -s /tmp/setup_customized.pds"
        rm /tmp/setup_customized.pds
        echo Setup done.
    fi
fi

