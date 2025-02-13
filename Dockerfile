ARG VERSION=1.11.3


## Second stage: Use ingress-nginx/controller image
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Install ngx_http_auth_jwt_module.so dependencies
RUN apk -U upgrade && apk add --no-cache \
    jansson \
    openssl \ 
    libjwt

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY --chown=www-data:www-data modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

RUN ln -s /usr/lib/libjwt.so.2 /usr/lib/libjwt0 
RUN ln -s /usr/lib/libjwt.so.2 /usr/lib/libjwt.so.0

USER www-data
