FROM centos

ENV DOM_CONF_FOLDER=resources/serverconfig
ENV DOM_CONF_FILENAME=domino1001_response.dat

ENV DOM_DOMINO_INSTALLER_FOLDER=resources/domino_installer
ENV DOM_DOMINO_INSTALLER_FILENAME=DOM_SVR_V10.0.1_64_BIT_Lnx.tar

# Location of Domino start/stop script:
ENV DOM_STARTSCRIPT_FOLDER=resources/initscripts
ENV DOM_STARTSCRIPT_INSTALLARCHIVE_FILENAME=domino_start_script_320.tar

# environment variable required by Domino setup
ENV NUI_NOTESDIR /opt/ibm/domino/

USER root

# install latest linux patches and setup notes user and group

RUN yum update -y && \
    yum install -y which && \
    yum install -y nano && \
    yum install -y wget && \
    yum install -y bc && \
    yum install -y perl && \
    yum clean all && \
    useradd -ms /bin/bash notes && \
    usermod -aG notes notes && \
    usermod -d /local/notesdata notes && \
    sed -i '$d' /etc/security/limits.conf && \
    echo 'notes soft nofile 60000' >> /etc/security/limits.conf && \
    echo 'notes hard nofile 80000' >> /etc/security/limits.conf && \
    echo '# End of file' >> /etc/security/limits.conf && \
    mkdir -p /tmp/sw-repo/serverconfig && \
    mkdir -p /tmp/sw-repo/initscripts

# copy the Domino server installer archive
COPY ${DOM_DOMINO_INSTALLER_FOLDER}/${DOM_DOMINO_INSTALLER_FILENAME} /tmp/sw-repo/${DOM_DOMINO_INSTALLER_FILENAME}

# copy Daniel Nashed's start script install archive
COPY ${DOM_STARTSCRIPT_FOLDER}/${DOM_STARTSCRIPT_INSTALLARCHIVE_FILENAME} /tmp/sw-repo/initscripts/domino_start_script.tar
# copy the server setup file (which components to install)
COPY ${DOM_CONF_FOLDER}/${DOM_CONF_FILENAME} /tmp/sw-repo/serverconfig/

# extract domino installer and do a silent installation,
# then extract and install Domino start/stop script; after all cleanup the tmp folder

RUN cd /tmp/sw-repo/ && \
    tar -xf ${DOM_DOMINO_INSTALLER_FILENAME} &&\
    cd /tmp/sw-repo/linux64/domino && \
    /bin/bash -c "./install -silent -options /tmp/sw-repo/serverconfig/${DOM_CONF_FILENAME}" && \
    cd /tmp/sw-repo/initscripts && \
    tar -xvf /tmp/sw-repo/initscripts/domino_start_script.tar && \
    /tmp/sw-repo/initscripts/start_script/install_script && \
    cd / && \
    rm /tmp/* -R

WORKDIR /local/notesdata
ENV LOGNAME=notes
ENV PATH=$PATH:/opt/ibm/domino/

# define which internal ports to expose when running (e.g. 25 for SMTP, 80/443 for HTTP and 1352 for Notes)

EXPOSE 25 80 443 1352

CMD ["/domino_docker_entrypoint.sh"]
