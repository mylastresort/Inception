from alpine:3.14

expose 443

arg DOMAIN_NAME

run [ -n "$DOMAIN_NAME" ]

run apk add --no-cache nginx openssl 

copy conf/default.conf /etc/nginx/http.d/default.conf

run echo $DOMAIN_NAME

run sed -e "s/example.com/$DOMAIN_NAME/g" -i /etc/nginx/http.d/default.conf

workdir /opt/nginx/ssl

cmd openssl req -x509 -nodes -days 365 -newkey rsa:2048\
 -keyout ssl.key -out ssl.crt\
 -subj "/C=US/CN=$DOMAIN_NAME"\
 && nginx -g 'daemon off;'
