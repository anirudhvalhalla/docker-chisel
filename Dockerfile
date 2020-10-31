FROM debian:stable-slim

RUN mkdir -p /app/bin
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates
RUN curl -sOL https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64.deb && dpkg -i dumb-init_*.deb && rm dumb-init_*.deb
RUN curl -sL https://github.com/nadoo/glider/releases/download/v0.11.1/glider_0.11.1_linux_amd64.tar.gz | tar -xvz --strip 1 --wildcards glider_*/glider && mv glider /app/bin/glider && chmod +x /app/bin/glider
RUN curl -sOL https://github.com/jpillora/chisel/releases/download/v1.7.1/chisel_1.7.1_linux_amd64.gz && gzip -d chisel_*.gz && mv chisel_* /app/bin/chisel && chmod +x /app/bin/chisel
COPY start.sh /app
RUN chmod +x /app/start.sh
ENV PATH="$PATH:/app/bin"
WORKDIR /app

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD /app/start.sh