/usr/bin/mysqld_safe --skip-syslog &
sleep 5
/usr/bin/mysql -u root -e "CREATE USER 'paynedigital'@'%';"
/usr/bin/mysql -u root -e "CREATE DATABASE paynedigital;"
/usr/bin/mysql -u root -e "GRANT ALL ON paynedigital.* to 'paynedigital'@'%';"
