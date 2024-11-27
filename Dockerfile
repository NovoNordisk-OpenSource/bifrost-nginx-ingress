ARG VERSION=1.11.3

# First stage: Build libjwt0 from Ubuntu
FROM ubuntu:bionic AS builder

# Install libjwt0
RUN apt-get update && apt-get install -y libjwt0

# Second stage: Use ingress-nginx/controller image
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY --chown=www-data:www-data modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

# Copy libjwt0 and it's dependencies from the builder stage
COPY --from=builder /usr/lib/libjwt.so.0 /usr/lib/
COPY --from=builder /usr/lib/aarch64-linux-gnu/libb64.so.0d /usr/lib/

# Install ngx_http_auth_jwt_module.so dependencies
RUN apk add --no-cache \
    jansson \
    openssl \
    libjwt

# Change the ownership of the copied file to www-data
RUN chown www-data:www-data /etc/nginx/modules/ngx_http_auth_jwt_module.so

USER www-data
