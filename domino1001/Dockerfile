FROM centos

ENV DOM_SCR=resources/initscripts
ENV DOM_CONF=resources/serverconfig/domino1001_response.dat
ENV DOM_ENTRYPOINT_FILE=resources/entrypoint/domino_docker_entrypoint.sh
ENV DOM_DOMINO10INSTALLER=resources/domino1001installer/DOM_SVR_V10.0.1_64_BIT_Lnx.tar

# environment variable required by Domino setup

ENV NUI_NOTESDIR /opt/ibm/domino/

# install latest linux patches and setup notes user and group

RUN yum update -y && \
    yum install -y which && \
    yum install -y nano && \
    yum install -y wget && \
    yum install -y bc && \
    yum install -y perl && \
    useradd -ms /bin/bash notes && \
    usermod -aG notes notes && \
    usermod -d /local/notesdata notes && \
    sed -i '$d' /etc/security/limits.conf && \
    echo 'notes soft nofile 60000' >> /etc/security/limits.conf && \
    echo 'notes hard nofile 80000' >> /etc/security/limits.conf && \
    echo '# End of file' >> /etc/security/limits.conf

RUN mkdir -p /tmp/sw-repo && \
    mkdir -p /tmp/sw-repo/serverconfig

# copy the Domino 10 installer archive
COPY ${DOM_DOMINO10INSTALLER} /tmp/sw-repo/

# copy the server setup file (which components to install)
COPY ${DOM_CONF} /tmp/sw-repo/serverconfig/

# copy entrypoint file to start the initial server setup or the server process
COPY ${DOM_ENTRYPOINT_FILE} /domino_docker_entrypoint.sh
RUN chmod 775 /domino_docker_entrypoint.sh

# download domino installer and do a silent installation
RUN cd /tmp/sw-repo/ && \
    tar -xf DOM_SVR_V10.0.1_64_BIT_Lnx.tar &&\
    cd /tmp/sw-repo/linux64/domino && \
    /bin/bash -c "./install -silent -options /tmp/sw-repo/serverconfig/domino1001_response.dat" && \
    cd / && \
    rm /tmp/* -R

# copy startup script and set execution rights

RUN mkdir -p /etc/sysconfig/
COPY ${DOM_SCR}/rc_domino /etc/init.d/
RUN chmod u+x /etc/init.d/rc_domino && \
    chown root.root /etc/init.d/rc_domino
COPY ${DOM_SCR}/rc_domino_script /opt/ibm/domino/
RUN chmod u+x /opt/ibm/domino/rc_domino_script && \
    chown notes.notes /opt/ibm/domino/rc_domino_script
COPY ${DOM_SCR}/rc_domino_config /etc/sysconfig/

USER notes
WORKDIR /local/notesdata
ENV LOGNAME=notes
ENV PATH=$PATH:/opt/ibm/domino/

# define which internal ports to expose when running

EXPOSE 25 80 443 1352

CMD ["/domino_docker_entrypoint.sh"]
