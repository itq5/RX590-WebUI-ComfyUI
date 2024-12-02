FROM docker.7ii.win/python:3.10-slim-bullseye
ENV DEBIAN_FRONTEND=noninteractive

RUN /bin/echo -e '#!/bin/bash\nDEBIAN_FRONTEND=noninteractive\napt-get update && apt-get install -y $@ && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/apt/lists/*' \
    > /usr/local/sbin/apt_install_clean.sh && \
    chmod a+x /usr/local/sbin/apt_install_clean.sh
RUN /bin/echo -e '#!/bin/bash\nDEBIAN_FRONTEND=noninteractive\napt-get update && apt-get remove -y $@ && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/apt/lists/*' \
    > /usr/local/sbin/apt_remove_clean.sh && \
    chmod a+x /usr/local/sbin/apt_remove_clean.sh

# install some utilities for troubleshooting
RUN /usr/local/sbin/apt_install_clean.sh iputils-ping net-tools curl wget gnupg2 nano git


RUN mkdir -p /root/git
WORKDIR /root/git

# check out stable diffusion
RUN git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git
WORKDIR sd-webui-infinite-image-browsing
RUN git fetch && git checkout v1.2.0
RUN pip install --upgrade pip && pip install -r requirements.txt && pip cache purge

# build validation
RUN which ping
RUN which netstat
RUN which curl
RUN which wget
RUN which nano

COPY entry.sh /usr/local/sbin
# these are needed to make search work correctly
#COPY config.json /
RUN sed -i s_/root_/outputs_ /etc/passwd

ENTRYPOINT [ "sh", "-c", "/usr/local/sbin/entry.sh" ]
