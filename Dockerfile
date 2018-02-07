#
# Dockerfile for Golang
#

FROM alpine:3.7
LABEL maintainer="appsvc-images@microsoft.com"


COPY entrypoint.sh /bin/
COPY startup/hostingstart.html /home/site/wwwroot/
COPY startup/defaultstaticwebapp /defaulthome/hostingstart/
COPY sshd_config /etc/ssh/

RUN apk update \
    && apk upgrade \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> ~/.profile \
    && apk add --update --no-cache openrc openssh file findutils ca-certificates \
    && rc-update add sshd \
    && chmod 755 /bin/entrypoint.sh \
    && mkdir -p /home/LogFiles/ \
    && /usr/bin/ssh-keygen -A

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/entrypoint.sh"]
