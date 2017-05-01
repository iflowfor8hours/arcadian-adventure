FROM nginx:alpine
ARG NGINX_CONF
ENV NGINX_CONF=$NGINX_CONF
RUN echo $NGINX_CONF > /etc/nginx/nginx.conf
COPY public /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html
