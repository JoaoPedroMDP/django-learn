FROM python:3.11-alpine

RUN apk update \
    && apk add --no-cache \
    gcc \
    musl-dev \
    mariadb-dev \
    mariadb-client \
    python3-dev \
    && rm -rf /var/cache/apk/*

COPY . /app
RUN pip3 install -r /app/requirements.txt

# ENTRYPOINT [ "/opt/entrypoint.sh" ]

WORKDIR /app

CMD ["/usr/local/bin/gunicorn","-b", "0.0.0.0:8000", "-w", "2","-t", "60", "learn.wsgi"]
