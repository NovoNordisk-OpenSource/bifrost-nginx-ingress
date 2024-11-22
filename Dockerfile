ARG VERSION=1.11.2
FROM registry.k8s.io/ingress-nginx/controller:v${VERSION}

# Copy the ngx_http_auth_jwt_module.so file to the /etc/nginx/modules/ folder
COPY modules/ngx_http_auth_jwt_module.so /etc/nginx/modules/