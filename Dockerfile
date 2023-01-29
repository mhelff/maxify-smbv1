FROM alpine:3.10

ARG USER='smb'
ARG PASS='smbpass'

RUN apk add --no-cache --update sudo

# install samba
RUN sudo apk add samba-common-tools samba-client samba-server

# create user
RUN adduser -D -s /bin/ash -u 1000 ${USER}

# add user to root group
RUN addgroup ${USER} root
RUN echo ''${USER}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo -ne ""${PASS}"\n"${PASS}"\n" | sudo smbpasswd -a -s ${USER}
RUN echo -ne ""${PASS}"\n"${PASS}"\n" | sudo passwd ${USER}
USER ${USER}

COPY smb.conf /etc/samba/smb.conf

# default configuration
ENV NETBIOS_NAME=MAXIFYSMBV1
ENV WORKGROUP=WORKGROUP
ENV SHARE1=SHARE1
ENV SHARE1_COMMENT="The first share"
ENV SHARE2=SHARE2
ENV SHARE2_COMMENT="The second share"


EXPOSE 445/tcp
EXPOSE 445/udp

EXPOSE 139/tcp
EXPOSE 139/udp

EXPOSE 137/tcp
EXPOSE 137/udp

EXPOSE 138/tcp
EXPOSE 138/udp

CMD ["sudo", "-E", "smbd", "--foreground", "--log-stdout", "--no-process-group"]
