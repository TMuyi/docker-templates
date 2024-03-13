FROM debian:bullseye-20240311-slim

RUN apt-get update \
    && apt-get install -y iperf3 

EXPOSE 5201

CMD ["iperf3","-s"]