FROM php:7.4-cli

# install git (update + install in one layer so apt indexes stay fresh)
RUN apt-get update \
	&& apt-get install -y --no-install-recommends git \
	&& rm -rf /var/lib/apt/lists/*

ARG file_name
ARG version
ARG sandbox
ARG release_mode

COPY deploy.php /deploy.php
COPY ${file_name} /${file_name}
RUN git clone https://github.com/Freemius/freemius-php-sdk.git /freemius-php-api

EXPOSE 80/tcp
EXPOSE 80/udp

CMD php /deploy.php
