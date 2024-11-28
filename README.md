# bifrost-nginx-ingress

## 🚨 🚧 WORK IN PROGRESS 🚧 🚨

This repo provides a customized NGINX ingress controller image used in Ingress Controller for NGINX

- Original NGINX ingress controller Docker file [here](https://github.com/kubernetes/ingress-nginx/blob/main/rootfs/Dockerfile)
- Original NGINX ingress releases [here](https://github.com/kubernetes/ingress-nginx/releases)

## Modules

The image includes the following extra NGINX modules:

- [ngx-http-auth-jwt-module](https://github.com/TeslaGov/ngx-http-auth-jwt-module)

These modules are stored in the `modules` directory, and their respective versions are recorded in the [versions.txt](./modules/versions.txt) file.
