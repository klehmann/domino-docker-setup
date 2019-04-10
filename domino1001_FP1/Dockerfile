FROM klehmann/domino:10.0.1

ENV DOM_SRC=resources/
ENV DOM_DOMINO10001FP1INSTALLER=resources/domino10001FP1_linux64.tar

# environment variable required by Domino setup

ENV NUI_NOTESDIR /opt/ibm/domino/

RUN mkdir -p /tmp/sw-repo

# copy the Domino 10.0.1 FP1 installer archive
COPY ${DOM_DOMINO10001FP1INSTALLER} /tmp/sw-repo/

USER root
RUN cd /tmp/sw-repo && \
    tar -xf domino10001FP1_linux64.tar && \
    cd /tmp/sw-repo/linux64/domino && \
    /bin/bash -c "./install -script /tmp/sw-repo/serverconfig/domino10001_fp1_response.dat" && \
    cd / && \
    rm /tmp/* -R
USER notes