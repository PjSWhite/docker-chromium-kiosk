FROM debian:bookworm

ARG BUILD_DATE

LABEL org.label-schema.build-date=$BUILD_DATE

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends chromium chromium-sandbox && \
    apt-get clean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

ADD chrome-virtual-keyboard.tar.gz /chrome-extensions

COPY start-chromium.sh /usr/bin/start-browser

# Default display connected to the machine
ENV DISPLAY=:0 

ENTRYPOINT ["/usr/bin/start-browser"]