ARG VERSION=1.11.2
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Install ngx_http_auth_jwt_module.so dependencies
RUN apk add --no-cache \
    jansson \
    openssl \ 
    libjwt \
    libjwt-dev \
    libjwt0 \
    libjansson-dev \
    libjansson4 \
    libpcre2-dev \
    zlib1g-dev \
    libpcre3-dev
    
# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

# Change the ownership of the copied file to www-data
RUN chown www-data:www-data /etc/nginx/modules/ngx_http_auth_jwt_module.so

USER www-data
