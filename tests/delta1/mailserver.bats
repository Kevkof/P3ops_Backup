#{{{ Variables
ip=172.16.128.135
#}}}

# Test cases

@test 'The necessary packages should be installed' {
  rpm -q httpd
  rpm -q postfix
  rpm -q dovecot
  rpm -q php
}

@test 'The Postfix service should be running' {
  systemctl status postfix.service
}

@test 'The Dovecot service should be running' {
  systemctl status postfix.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}

@test 'Web and mail traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
  firewall-cmd --list-all | grep 'services.*imap\b'
  firewall-cmd --list-all | grep 'services.*imaps\b'
  firewall-cmd --list-all | grep 'services.*pop3\b'
  firewall-cmd --list-all | grep 'services.*pop3s\b'
  firewall-cmd --list-all | grep 'services.*smtp\b'
  firewall-cmd --list-all | grep 'services.*smtps\b'
  firewall-cmd --list-all | grep 'services.*smtp-submission\b'
}

@test 'The users robbe and robin should exists' {
  cat /etc/passwd | grep 'robbe'
  cat /etc/passwd | grep 'robin'
}

@test 'The website should be accessible through HTTP at the right ip address' {
  #checking port 80 is open?
  [ -n "$(ss -tln | grep '\b80\b')" ]

  run curl --silent "http://${ip}/"
  [ -z "$(echo ${output} | grep 404)" ]
}

@test "The squirrelmail page should be visible under http://${ip}/squirrelmail/" {
  curl -Is http://172.16.128.135/squirrelmail | head -n 1
}
