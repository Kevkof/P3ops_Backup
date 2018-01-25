#! /usr/bin/env bats
#
# Acceptance test for the slave DNS server for green.local

sut_ip=172.16.128.132

#{{{ Helper functions

#}}}

@test 'De ldap client tools moeten geïnstalleerd zijn.' {
  which ldapsearch
  which ldapwhoami
}

@test 'Er verbonden worden met LDAP met user "admin" en wachtwoord "password".' {
  ldapwhoami -x -w "password" -D "cn=admin"
}

@test 'De gewenste users bevinden zich in de LDAP database.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "uid=lander" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "uid=torvalds" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "uid=rms" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "uid=knuth" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "uid=dmr" | grep "dn:"
}

@test 'Het wachtwoord van alle users is "password"' {
  ldapwhoami -x -w "password" -D "uid=lander,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "password" -D "uid=torvalds,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "password" -D "uid=rms,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "password" -D "uid=knuth,ou=People,dc=green,dc=local"
  ldapwhoami -x -w "password" -D "uid=dmr,ou=People,dc=green,dc=local"
}

@test 'De gewenste groepen bevinden zich in de LDAP database.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=itadministratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=verkoop" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=administratie" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=ontwikkeling" | grep "dn:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=directie" | grep "dn:"
}


@test 'De groepen bevatten minstens 1 gebruiker.' {
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=itadministratie" | grep "memberUid:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=verkoop" | grep "memberUid:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=administratie" | grep "memberUid:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=ontwikkeling" | grep "memberUid:"
  ldapsearch -x -b "dc=green,dc=local" -D "cn=admin" -w password "cn=directie" | grep "memberUid:"
}
