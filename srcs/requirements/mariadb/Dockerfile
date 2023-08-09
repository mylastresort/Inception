from alpine:3.14

expose 3306

arg DB_NAME DB_USER DB_PASS RT_PASS

run [ -n "$DB_NAME" -a -n "$DB_USER" -a -n "$DB_PASS" -a -n "$RT_PASS" ]

run apk add --no-cache mariadb mariadb-client

run mariadb-install-db --datadir=/var/lib/mariadb --user=mysql

run mariadbd-safe --datadir=/var/lib/mariadb --nowatch\
 && sleep 2\
 && mariadb -e "create database $DB_NAME;"\
 -e "grant all privileges on $DB_NAME.* to '$DB_USER'@'%' identified by '$DB_PASS';"\
 -e "flush privileges;"\
 -e "alter user root@'localhost' identified by '$RT_PASS';"\
 -e "flush privileges;"

copy conf/my.cnf /etc/my.cnf

cmd mariadbd -uroot --datadir=/var/lib/mariadb
