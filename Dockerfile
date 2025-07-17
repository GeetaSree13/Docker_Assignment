FROM alpine:latest
LABEL "Author"="geeta"
LABEL "Project"="demo"

RUN apk update && apk add openjdk17

RUN apk upgrade

RUN adduser -D appuser && \
    mkdir /app && \
    chown appuser:appuser /app && \
    chmod 750 /app && \
    chmod 700 /home /root /etc /var /opt /media /mnt || true
