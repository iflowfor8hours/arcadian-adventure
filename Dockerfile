FROM nginx:alpine
COPY public /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html
COPY dev/nginx.conf /etc/nginx/nginx.conf
