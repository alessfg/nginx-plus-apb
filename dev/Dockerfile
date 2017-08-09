FROM docker.io/centos:7

ENV NGINX_VERSION="1.11.10 (nginx-plus-r12-p3)"

LABEL name="nginxinc/nginx-plus" \
      maintainer="NGINX Docker Maintainers <docker-maint@nginx.com>" \
      vendor="NGINX Inc." \
      version="${NGINX_VERSION}" \
      release="1" \
      summary="NGINX Plus: The complete application delivery platform for the modern enterprise." \
      description="NGINX (pronounced \"engine-x\") is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors." \
### Required labels above - recommended below
      url="https://www.nginx.com/" \
      io.k8s.display-name="NGINX Plus" \
      io.openshift.expose-services="http:8080" \
      io.openshift.tags="nginx,nginxinc"

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
COPY ./certs/nginx-repo.crt /etc/ssl/nginx/
COPY ./certs/nginx-repo.key /etc/ssl/nginx/

# Add NGINX Plus repo to yum
ADD nginx-plus.repo /etc/yum.repos.d/nginx-plus.repo

# Install NGINX Plus
RUN yum -y install --setopt=tsflags=nodocs nginx-plus && \
    yum clean all

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
# Change pid file location & remove nginx user & change port to 8080
    sed -i 's/\/var\/run\/nginx.pid/\/var\/cache\/nginx\/nginx.pid/g' /etc/nginx/nginx.conf && \
    sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /etc/nginx/nginx.conf && \
    sed -i -e '/listen/!b' -e '/80;/!b' -e 's/80;/8080;/' /etc/nginx/conf.d/default.conf && \
# Modify perms for non-root runtime
    chown -R 998 /var/cache/nginx /etc/nginx && \
    chmod -R g=u /var/cache/nginx /etc/nginx

VOLUME ["/var/cache/nginx"]

EXPOSE 8080 8443

USER 998

CMD ["nginx", "-g", "daemon off;"]
