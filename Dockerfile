ARG VERSION=1.11.3

# First stage: Build libjwt0 from Ubuntu
FROM ubuntu:bionic as builder

# Install libjwt0
RUN apt-get update && apt-get install -y libjwt0

# Second stage: Use ingress-nginx/controller image
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

# Copy libjwt0 from the builder stage
COPY --from=builder /usr/lib/libjwt.so.0 /usr/lib/libjwt.so.0

# Install ngx_http_auth_jwt_module.so dependencies
RUN apk add --no-cache \
    jansson \
    openssl \
    libjwt

RUN apk add libb64 --no-cache --repository https://pkgs.alpinelinux.org/packages?name=&branch=edge&repo=testing

# Change the ownership of the copied file to www-data
RUN chown www-data:www-data /etc/nginx/modules/ngx_http_auth_jwt_module.so

USER www-data

CMD ["ls", "-l", "/usr/lib"]