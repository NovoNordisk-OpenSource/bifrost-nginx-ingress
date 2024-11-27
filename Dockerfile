ARG VERSION=1.11.3

## First stage: Get libjwt0 from Ubuntu
FROM ubuntu:bionic AS builder
ARG TARGETPLATFORM

# Install libjwt0
RUN apt-get update && apt-get install -y libjwt0

# Conditional copy based on the platform
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        cp /usr/lib/x86_64-linux-gnu/libb64.so.0d /usr/lib/; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        cp /usr/lib/aarch64-linux-gnu/libb64.so.0d /usr/lib/; \
    fi

## Second stage: Use ingress-nginx/controller image
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY --chown=www-data:www-data modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

# Copy libjwt0 and it's dependencies from the builder stage
COPY --from=builder /usr/lib/libjwt.so.0 /usr/lib/
COPY --from=builder /usr/lib/libb64.so.0d /usr/lib/

# Install ngx_http_auth_jwt_module.so dependencies
RUN apk add --no-cache \
    jansson \
    openssl \
    libjwt

USER www-data
