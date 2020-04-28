FROM nginx:stable-alpine

# RUN apk add --no-cache openssl
# RUN mkdir -p /etc/cert
# RUN openssl req -out nginxlocal.csr -new -newkey rsa:2048 -nodes -keyout /etc/cert/nginxlocal.key \
#     -subj "/C=BR/ST=SaoPaulo/L=Brasil/O=Photo/OU=IT Department/CN=local.photo.com"
# RUN openssl req -new -key /etc/cert/nginxlocal.key -x509 -days 365 -out /etc/cert/nginxlocal.crt \
#     -subj "/C=BR/ST=SaoPaulo/L=Brasil/O=Photo/OU=IT Department/CN=local.photo.com"

#ADD script/autosslgen.sh /tmp/autosslgen.sh
#
#CMD [ "/tmp/autosslgen.sh" ]

COPY ./nginx.conf /etc/nginx/nginx.conf
#MAGENTO 2
COPY ./includes.d /etc/nginx/includes.d
COPY ./mage2.conf.d/* /etc/nginx/conf.d/
#MAGENTO 1
#COPY ./mage1.conf.d/* /etc/nginx/conf.d/
RUN mkdir -p /etc/letsencrypt
COPY ./certbot/* /etc/letsencrypt/


RUN mkdir -p /var/www/html
COPY ./www/* /var/www/html/

CMD ["nginx", "-g", "daemon off;"]