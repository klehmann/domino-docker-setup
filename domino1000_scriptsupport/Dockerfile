FROM klehmann/domino:10.0.0

ENV DOM_SETUP_PROFILE=resources/setup/setup.pds
ENV DOM_ENTRYPOINT_FILE=resources/entrypoint/docker-entrypoint_withsetup.sh

USER root

# copy base setup.pds file
COPY ${DOM_SETUP_PROFILE} /setup.pds

# copy entrypoint file to populate the setup file for the initial server setup
COPY ${DOM_ENTRYPOINT_FILE} /docker-entrypoint_withsetup.sh
RUN chmod 775 /docker-entrypoint_withsetup.sh

USER notes
WORKDIR /local/notesdata

# define which internal ports to expose when running
EXPOSE 25 80 443 1352

CMD ["/docker-entrypoint_withsetup.sh"]
