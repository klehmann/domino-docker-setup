FROM klehmann/domino:10.0.0

ENV DOM_SRC=resources/
ENV NUI_NOTESDIR /opt/ibm/domino/notes/latest/linux
    
COPY ${DOM_SRC}/ibm_domino_V10_appdev_pack_V1.0_linux64_beta.tar ${NUI_NOTESDIR}

RUN cd ${NUI_NOTESDIR} && \
	tar -xf ${NUI_NOTESDIR}/ibm_domino_V10_appdev_pack_V1.0_linux64_beta.tar && \
	cd /opt/ibm/domino/notes/latest/linux && \
	ls -la libnotes.so && \
	tar -xf ${NUI_NOTESDIR}/proton-addin-0.1.0-5497660.tgz && \
	/bin/bash -c "sh -v ./setup_proton.sh"

EXPOSE 25 80 443 1352 8085