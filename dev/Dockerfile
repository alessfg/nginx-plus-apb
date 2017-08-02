FROM docker.io/centos:7

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

# RUN yum -y install ca-certificates

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
COPY ./certs/nginx-repo.crt /etc/ssl/nginx/
COPY ./certs/nginx-repo.key /etc/ssl/nginx/

# Get other files required for installation
ADD nginx-plus.repo /etc/yum.repos.d/nginx-plus.repo

# Install NGINX Plus
RUN yum -y install --setopt=tsflags=nodocs nginx-plus && \
    # yum remove ca-certificates
    yum clean all
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
# change pid file location & port to 8080
    sed -i -e '/pid/!b' -e '/\/var\/run\/nginx.pid/!b' -e '/\/var\/run\/nginx.pid/d' /etc/nginx/nginx.conf && \
    sed -i -e '/listen/!b' -e '/80 default_server;/!b' -e 's/80 default_server;/8080 default_server;/' /etc/nginx/conf.d/default.conf && \
# modify perms for non-root runtime
    chown -R 998 /var/cache/nginx && \
    chmod -R g=u  /var/cache/nginx

VOLUME ["/var/cache/nginx"]

EXPOSE 8080 8443

USER 998

CMD ["nginx", "-g", "daemon off; pid /var/cache/nginx/nginx.pid;"]
