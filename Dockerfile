FROM nginx:1.21.1 AS nginx-base

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y man nano procps ca-certificates wget gnupg gnupg2 iputils-ping net-tools supervisor \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Open the default HTTPS (SSL) port
EXPOSE	80 443

WORKDIR /var/www

FROM nginx-base AS nginx-config

# Replace the original Nginx config file
COPY config/nginx.conf /etc/nginx/nginx.conf

COPY scripts/ /scripts/

RUN set -x \
    && chmod -R +x /scripts/ \
    && /scripts/permissions.sh \
    && touch /var/run/nginx.pid \
    && mkdir -p /etc/nginx/ssl \
    && chown -R www-data:www-data /etc/nginx/ssl \
    && chown -R www-data:www-data /var/run/nginx.pid \
    && chown -R www-data:www-data /var/log/nginx \
    && chown -R www-data:www-data /var/cache/nginx

# Test file
COPY scripts/index.html /var/www/html/index.html

