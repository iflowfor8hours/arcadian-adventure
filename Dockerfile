FROM nginx:alpine
ARG NGINX_CONF
ARG NGINX_SECURITY_CONF
ARG KEY_PEM
ARG FULLCHAIN_PEM
ARG CSR_PEM
ARG DHPARAM_PEM
ENV NGINX_CONF=$NGINX_CONF
ENV NGINX_SECURITY_CONF=$NGINX_SECURITY_CONF
ENV KEY_PEM=$KEY_PEM
ENV FULLCHAIN_PEM=$FULLCHAIN_PEM
ENV CSR_PEM=$CSR_PEM
ENV DHPARAM_PEM=$DHPARAM_PEM
RUN echo $NGINX_CONF > /etc/nginx/nginx.conf
RUN echo $KEY_PEM > /etc/ssl/key.pem
RUN echo $FULLCHAIN_PEM > /etc/ssl/fullchain.pem
RUN echo $CSR_PEM > /etc/ssl/csr.pem
RUN echo $DHPARAM_PEM > /etc/ssl/dhparam.pem
RUN echo $NGINX_SEC_CONF > /etc/nginx/nginx.conf

COPY public /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html
COPY dev/nginx-sec.conf /etc/nginx/nginx.conf
COPY keys/iflowfor8hours.info.key.pem /etc/ssl/key.pem
COPY keys/iflowfor8hours.info.fullchain.pem /etc/ssl/fullchain.pem
COPY keys/iflowfor8hours.info.csr.pem /etc/ssl/csr.pem
COPY keys/iflowfor8hours.info.dhparam.pem /etc/ssl/dhparam.pem

