FROM klehmann/domino:10.0.1

ENV DOM_SRC=resources/
ENV NUI_NOTESDIR /opt/ibm/domino/notes/latest/linux
    
COPY ${DOM_SRC}/DOMINO_APPDEV_PACK_1.0_LNX_EN.tar ${NUI_NOTESDIR}

USER root
RUN cd ${NUI_NOTESDIR} && \
	tar -xf ${NUI_NOTESDIR}/DOMINO_APPDEV_PACK_1.0_LNX_EN.tar && \
	cd /opt/ibm/domino/notes/latest/linux && \
	ls -la libnotes.so && \
	tar -xf ${NUI_NOTESDIR}/proton-addin-0.2.2.tgz && \
	/bin/bash -c "sh -v ./setup_proton.sh"

EXPOSE 25 80 443 1352 8085