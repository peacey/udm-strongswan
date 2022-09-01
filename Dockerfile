FROM arm64v8/debian:testing-slim

ARG DEBIAN_FRONTEND=noninteractive

COPY stretch-backports.list /etc/apt/sources.list.d/

RUN apt update && \
    apt install -y --no-install-recommends strongswan strongswan-swanctl libtss2-tcti-tabrmd0 \ 
	libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-standard-plugins \
	libstrongswan-extra-plugins ca-certificates procps psmisc iproute2 conntrack ipset && \
    apt install -y --no-install-recommends --allow-downgrades iptables/stretch-backports && \
    apt clean


COPY charon.conf /etc/strongswan.d/charon.conf

COPY start.sh /root
RUN chmod +x /root/start.sh
ENTRYPOINT ["/root/start.sh"]

