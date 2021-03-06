# Ringtools Web Docker

Files to run ringtools-web using docker

## Use with Umbrel

````yaml
version: "3.7"

services:
  ringtoolsweb:
    image: ghcr.io/ringtools/ringtools-web:latest
    ports:
      - "7464:7464"
    networks:
      - umbrel
    environment:
      - PORT=7464
      - LND_REST_API_WS=wss://10.21.21.9:8080
      - LND_REST_API=https://10.21.21.9:8080
      - MACAROON_FILE=/lnd/readonly.macaroon
      - TLS_CERT_FILE=/lnd/tls.cert
    volumes:
      - /home/umbrel/umbrel/lnd/tls.cert:/lnd/tls.cert:ro
      - /home/umbrel/umbrel/lnd/data/chain/bitcoin/mainnet/readonly.macaroon:/lnd/readonly.macaroon:ro
networks:
  umbrel:
    external: true
    name: umbrel_main_network
````