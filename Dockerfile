FROM debian:bookworm

ARG BUILD_DATE
ARG UID=1000
ARG GID=1000

LABEL org.label-schema.build-date=$BUILD_DATE

RUN groupadd -g ${GID} docker_user && \
  useradd -u ${UID} -g ${GID} -m -s /bin/bash docker_user

RUN apt-get -y update && \
  apt-get install -y --no-install-recommends chromium chromium-sandbox && \
  apt-get clean && apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/sudoers.d/ && \
  echo "docker_user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker_user && \
  chmod 0440 /etc/sudoers.d/docker_user

RUN chown -R ${UID}:${GID} /home/docker_user

ADD chrome-virtual-keyboard.tar.gz /chrome-extensions

COPY start-chromium.sh /usr/bin/start-browser

# Default display connected to the machine
ENV DISPLAY=:0

USER docker_user
ENV HOME=/home/docker_user

ENTRYPOINT ["/usr/bin/start-browser"]