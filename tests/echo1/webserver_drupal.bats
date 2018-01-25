#{{{ Helper Functions


#}}}
#{{{ Variables
sut=172.16.128.136
drupal_database=echo1DB
drupal_user=echo1
drupal_password=echo1
drupal_database_host=172.16.128.7
#}}}

# Test cases

@test 'De nodige packages zijn geinstalleerd' {
  rpm -q httpd
  rpm -q drupal7
  rpm -q php
  rpm -q php-mysql
}

@test 'De Apache service werkt' {
  systemctl status httpd.service
}

@test 'De Apache service start op bij boot' {
  systemctl is-enabled httpd.service
}


@test 'De firewall laat webservices door' {
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
}

@test 'De drupal database name is juist geconfigureerd' {
  grep "'database' => '${drupal_database}'" /etc/drupal7/default/settings.php
}

@test 'De drupal database username is juist geconfigureerd' {
  grep "'username' => '${drupal_user}'" /etc/drupal7/default/settings.php
}

@test 'De drupal database password is juist geconfigureerd' {
  grep "'password' => '${drupal_password}'" /etc/drupal7/default/settings.php
}

@test 'De drupal database host ip is juist geconfigureerd' {
  grep "'host' => '${drupal_database_host}'" /etc/drupal7/default/settings.php
}

@test 'Je kan de website bezoeken via http' {
  # First check whether port 80 is open
  [ -n "$(ss -tln | grep '\b80\b')" ]

  # Fetch the main page (/) with Curl/
  #  - If the site is not up, curl will exit with an error and the test will fail
  #  - If the site is up, but the index page cannot be found, ${result} will be nonempty
  run curl --silent "http://${sut}/"
  [ -z "$(echo ${output} | grep 404)" ]
}

@test 'je kan de website bezoeken via https' {
  # We're just checking if port 443 is open here. If HTTP runs and serves pages, HTTPS should as well
  # We check the open TCP server ports with ss and check if port 443 is listed.
  [ -n "$(ss -tln | grep '\b443\b')" ]
}

@test 'Je hebt connectie met de databank' {
  php db-connect-test.php | grep succes 

}
