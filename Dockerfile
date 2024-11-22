ARG VERSION=1.11.2
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

USER root

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/

# Change the ownership of the copied file to www-data
RUN chown www-data:www-data /etc/nginx/modules/ngx_http_auth_jwt_module.so

USER www-data
