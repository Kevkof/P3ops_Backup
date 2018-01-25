#! /usr/bin/env bats

#{{{ Variables
ip=172.16.128.6
#}}}

# Test cases

@test 'The necessary packages should be installed' {
  rpm -q httpd
  rpm -q wordpress
}

@test 'The Apache service should be running' {
  systemctl status httpd.service
}

@test 'The Apache service should be started at boot' {
  systemctl is-enabled httpd.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}

@test 'Web traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
}

@test 'Check if the firewall is allowing port 389/tcp' {
  [ -n "$(sudo firewall-cmd --list-all | grep '\b389/tcp\b')" ]
}

@test 'The website should be accessible through HTTP at the right ip address' {
  #checking port 80 is open?
  [ -n "$(ss -tln | grep '\b80\b')" ]

  run curl --silent "http://${ip}/"
  [ -z "$(echo ${output} | grep 404)" ]
}

@test "The Wordpress install page should be visible under http://${ip}/wordpress/" {
  [ -n "$(curl --silent --location http://${ip}/wordpress/ | grep 'Green')" ]
}
