FROM grafana/loki:${loki_version}

# Add loki config
COPY loki-config.yaml /etc/loki/loki-config.yaml

CMD [ "-config.file=/etc/loki/loki-config.yaml" ]