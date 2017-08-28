FROM docker.io/centos:7

ENV NGINX_VERSION="1.11.10 (nginx-plus-r12-p3)"

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
    sed -i -e '/listen/!b' -e '/80 default_server;/!b' -e 's/80 default_server;/8080 default_server;/' /etc/nginx/conf.d/default.conf && \
# Modify perms for non-root runtime
    chown -R 998 /var/cache/nginx /etc/nginx && \
    chmod -R g=u /var/cache/nginx /etc/nginx

VOLUME ["/var/cache/nginx"]

EXPOSE 8080 8443

USER 998

CMD ["nginx", "-g", "daemon off;"]
