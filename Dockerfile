# Copy of original Nginx dcoker image in private Docker Registry
FROM localhost:5000/nginx:1.21.1

# Replace the original Nginx config file
COPY config/nginx.conf /etc/nginx/nginx.conf

COPY scripts/ /scripts/

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y nano procps ca-certificates wget gnupg gnupg2 iputils-ping net-tools supervisor \
    && apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && chmod -R +x /scripts/ \
    && /scripts/permissions.sh \
    && touch /var/run/nginx.pid \
    && mkdir -p /etc/nginx/ssl \
    && chown -R www-data:www-data /etc/nginx/ssl \
    && chown -R www-data:www-data /var/run/nginx.pid \
    && chown -R www-data:www-data /var/log/nginx \
    && chown -R www-data:www-data /var/cache/nginx

WORKDIR /var/www

# Test file: call the phpinfo() function
COPY scripts/index.html /var/www/html/index.html

# Open the default HTTPS (SSL) port
EXPOSE	443

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]