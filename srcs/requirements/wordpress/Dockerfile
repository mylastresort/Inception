from alpine:3.14

expose 9000

workdir /var/www/wordpress

arg DB_NAME DB_USER DB_PASS DOMAIN_NAME AD_NAME AD_PASS AD_EMAIL TITLE US_NAME US_EMAIL ROLE US_PASS

run [ -n "$DB_NAME" -a -n "$DB_USER" -a -n "$DB_PASS" -a -n "$DOMAIN_NAME" \
 -a -n "$AD_NAME" -a -n "$AD_PASS" -a -n "$AD_EMAIL" -a -n "$TITLE" \
 -a -n "$US_NAME" -a -n "$US_EMAIL" -a -n "$ROLE" -a -n "$US_PASS" ]

run apk add --no-cache php8-fpm php8-mbstring php8-mysqli php8-phar

run sed -i /etc/php8/php-fpm.d/www.conf -e 's/127.0.0.1:9000/9000/'

run wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

run chmod +x /usr/local/bin/wp

run ln -s /usr/bin/php8 /usr/bin/php

run wp core download

run wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost='mariadb:3306' --skip-check

volume /var/www/wordpress

cmd if ! wp core is-installed; then\
 wp core install --skip-email --url=$DOMAIN_NAME --title="$TITLE"\
 --admin_user="$AD_NAME" --admin_password="$AD_PASS" --admin_email="$AD_EMAIL" --allow-root;\
 wp user create $US_NAME $US_EMAIL --role=$ROLE --user_pass=$US_PASS;\
 fi; php-fpm8 --nodaemonize\
