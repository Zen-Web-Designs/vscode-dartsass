# docker build --build-arg NODE_VERSION=${NODE_VERSION} -t vscode-plugin-dartsass:${NODE_VERSION} .
# docker build -t vscode-plugin-dartsass:10.16.3-alpine .

# https://hub.docker.com/_/node?tab=tags
# ARG NODE_VERSION=8.14.0-alpine
ARG NODE_VERSION=10.16.3-alpine
# Only specifically npm < 5.6 works for vsce.
# For more details refer to [vscode-vsce/issues/246](https://github.com/Microsoft/vscode-vsce/issues/246#issuecomment-379565583) .
ARG NPM_VERSION=5.5.1
FROM node:${NODE_VERSION}
RUN apk add python make g++
RUN node --version
RUN npm --version
RUN echo "npm updated on Nov 20 2019"
RUN npm install -g npm
ENV VSCE_VERSION=1.69.0

RUN echo "vsce @ ${VSCE_VERSION}"
RUN npm install -g vsce@${VSCE_VERSION}

ARG DEVEL_USER=develop
RUN cat /etc/os-release
RUN adduser -g "" -D  ${DEVEL_USER}

RUN adduser ${DEVEL_USER} node
RUN id ${DEVEL_USER}

USER ${DEVEL_USER}
WORKDIR /home/${DEVEL_USER}

RUN vsce --version
RUN npm --version

WORKDIR /tmp

ENTRYPOINT /bin/sh -c "while true; do echo hello; sleep 100; done"
