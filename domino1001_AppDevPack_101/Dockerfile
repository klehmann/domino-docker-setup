FROM klehmann/domino:10.0.1.FP1

ENV DOM_SRC=resources/
ENV NUI_NOTESDIR /opt/ibm/domino/notes/latest/linux
    
COPY ${DOM_SRC}/DOMINO_APPDEV_PACK_1.0.1_MP_EN.tar ${NUI_NOTESDIR}

USER root
RUN yum install -y epel-release && \
	yum install -y nodejs npm && \
	yum install -y mod_ssl

RUN cd ${NUI_NOTESDIR} && \
	tar -xf ${NUI_NOTESDIR}/DOMINO_APPDEV_PACK_1.0.1_MP_EN.tar && \
	cd /opt/ibm/domino/notes/latest/linux && \
	ls -la libnotes.so && \
	tar -xf ${NUI_NOTESDIR}/DOMINO_APPDEV_PACK_1.0.1_MP_EN/DOMINO_APPDEV_PACK_1.0.1_MP_EN/proton-addin-0.3.1.tgz && \
	tar -xf ${NUI_NOTESDIR}/DOMINO_APPDEV_PACK_1.0.1_MP_EN/DOMINO_APPDEV_PACK_1.0.1_MP_EN/oauth-dsapi-0.3.1.tgz && \
	tar -xf ${NUI_NOTESDIR}/DOMINO_APPDEV_PACK_1.0.1_MP_EN/DOMINO_APPDEV_PACK_1.0.1_MP_EN/domino-iam-service-1.1.4.tgz && \
	/bin/bash -c "sh -v ./setup_proton.sh" && \
	/bin/bash -c "sh -x ./setup_dsapi.sh"

EXPOSE 25 80 443 1352 3002