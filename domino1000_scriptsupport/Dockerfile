FROM klehmann/domino:10.0.0
  
# Location of Domino start/stop script:
ENV DOM_STARTSCRIPT_FOLDER=resources/initscripts
# Tweaked version of the entrypoint script that exits the container after initial setup
ENV DOM_STARTSCRIPT_CUSTOM_FILENAME=domino_docker_entrypoint_custom.sh

ENV DOM_SETUP_FOLDER=resources/setup
ENV DOM_SETUP_CONFIGURESERVER_FILENAME=domino_configure_serversetup.sh

USER root

# copy base setup.pds file
COPY ${DOM_SETUP_FOLDER}/setup.pds /setup.pds

# copy configure script to set up server on first start
COPY ${DOM_SETUP_FOLDER}/${DOM_SETUP_CONFIGURESERVER_FILENAME} /docker_prestart.sh
RUN chmod 775 /docker_prestart.sh

# copy our modified entrypoint script that stops after initial setup
COPY ${DOM_STARTSCRIPT_FOLDER}/${DOM_STARTSCRIPT_CUSTOM_FILENAME} /domino_docker_entrypoint_custom.sh
RUN chmod 775 /domino_docker_entrypoint_custom.sh

WORKDIR /local/notesdata

# define which internal ports to expose when running
EXPOSE 25 80 443 1352

CMD ["/domino_docker_entrypoint_custom.sh"]

