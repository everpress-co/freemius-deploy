FROM php:8.3-cli-bookworm

# php:7.4-cli (Bullseye) fails apt installs with debian-security 404s.
# Fetch a pinned Freemius PHP SDK release — no apt/git needed.
ADD https://github.com/Freemius/freemius-php-sdk/archive/refs/tags/1.1.1.tar.gz /tmp/freemius-php-sdk.tar.gz
RUN mkdir -p /freemius-php-api \
	&& tar -xzf /tmp/freemius-php-sdk.tar.gz -C /freemius-php-api --strip-components=1 \
	&& rm /tmp/freemius-php-sdk.tar.gz

ARG file_name
ARG version
ARG sandbox
ARG release_mode

COPY deploy.php /deploy.php
COPY ${file_name} /${file_name}

EXPOSE 80/tcp
EXPOSE 80/udp

CMD ["php", "/deploy.php"]
