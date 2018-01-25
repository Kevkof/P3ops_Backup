#! /usr/bin/env bats
#
#
# Acceptance test script for a LAMP stack with Wordpress
#

#{{{ Variables

ip_address=172.16.128.7
mariadb_root_password=november1
mariadb_root_user=november1

echo1_database=echo1DB
echo1_database_user=echo1
echo1_database_password=echo1

mike1_database=mike1DB
mike1_database_user=mike1
mike1_database_password=mike1

#}}}

# Test cases

@test 'The MariaDB service should be running' {
  systemctl status mariadb.service
}

@test 'The MariaDB service should be started at boot' {
  systemctl is-enabled mariadb.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}

@test 'Mysql traffic should pass through the firewall' {
  firewall-cmd --list-all | grep mysql
}

@test 'Mariadb should have a root user "november1" and password "november1"' {
  #mysql -uecho1 -p${echo1_database_password} --execute 'show tables' ${echo1_database}
  mysql -u${mariadb_root_user} -p${mariadb_root_password} -h172.16.128.7 --execute 'SHOW DATABASES'
}

@test 'Mariadb should have a DB "echo1DB"' {
  mysql -u${mariadb_root_user} -p${mariadb_root_password} -h172.16.128.7 --execute 'show tables' ${echo1_database}
}

@test 'Mariadb should have a DB "mike1DB"' {
  mysql -u${mariadb_root_user} -p${mariadb_root_password} -h172.16.128.7 --execute 'show tables' ${mike1_database}
}

@test 'The MariaDB root user (november1) user should have "write access" to the database' {
  mysql -u${mariadb_root_user} -p${mariadb_root_password} -h172.16.128.7 --execute 'CREATE TABLE a (id int); DROP TABLE a;' ${mike1_database}
}
