#! /usr/bin/env bats
#
# Acceptance test for the DNS server for green.local

sut_ip=172.16.128.133
domain=green.local

#{{{ Helper functions

# Usage: assert_forward_lookup NAME IP
# Exits with status 0 if NAME.DOMAIN resolves to IP, a nonzero
# status otherwise
assert_forward_lookup() {
  local name="$1"
  local ip="$2"

  [ "$ip" = "$(dig @${sut_ip} ${name}.${domain} +short)" ]
}

# Usage: assert_reverse_lookup NAME IP
# Exits with status 0 if a reverse lookup on IP resolves to NAME,
# a nonzero status otherwise
assert_reverse_lookup() {
  local name="$1"
  local ip="$2"

  [ "${name}.${domain}." = "$(dig @${sut_ip} -x ${ip} +short)" ]
}

# Usage: assert_alias_lookup ALIAS NAME IP
# Exits with status 0 if a forward lookup on NAME resolves to the
# host name NAME.DOMAIN and to IP, a nonzero status otherwise
assert_alias_lookup() {
  local alias="$1"
  local name="$2"
  local ip="$3"
  local result="$(dig @${sut_ip} ${alias}.${domain} +short)"

  echo ${result} | grep "${name}\.${domain}\."
  echo ${result} | grep "${ip}"
}

#}}}

@test 'Het `dig` commando zou moeten geïnstalleerd zijn.' {
  which dig
}

@test 'Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.' {
  named-checkconf /etc/named.conf
}

@test 'De forward zone bestand zou syntactisch correct moeten zijn.' {
  # It is assumed that the name of the zone file is the name of the zone
  # itself (without extra extension)
  named-checkzone ${domain} /var/named/${domain}
}

@test 'Het reverse zone bestand zou syntactisch correct moeten zijn.' {
  # It is assumed that the name of the zone file is the name of the zone
  # itself (without extra extension)
  for zone_file in /var/named/*.in-addr.arpa; do
    reverse_zone=${zone_file##*/}
    named-checkzone ${reverse_zone} ${zone_file}
  done
}

@test 'De service zou moeten draaien.' {
  systemctl status named
}

@test 'Forward lookups van publieke servers uit VLAN 50.' {
  #                     hostname   IP
  assert_forward_lookup alfa1      172.16.128.132
  assert_forward_lookup bravo1     172.16.128.133
  assert_forward_lookup charlie1   172.16.128.134
  assert_forward_lookup delta1     172.16.128.135
  assert_forward_lookup echo1      172.16.128.136
}

@test 'Forward lookups van interne servers uit VLAN 30.' {
  #                     hostname   IP
  assert_forward_lookup kilo1      172.16.128.4
  assert_forward_lookup lima1      172.16.128.5
  assert_forward_lookup mike1      172.16.128.6
  assert_forward_lookup november1  172.16.128.7
  assert_forward_lookup oscar1     172.16.128.8
  assert_forward_lookup papa1      172.16.128.9
  assert_forward_lookup quebec1    172.16.128.10
}

@test 'Reverse lookups van publieke servers uit VLAN 50.' {
  #                     hostname   IP
  assert_reverse_lookup alfa1      172.16.128.132
  assert_reverse_lookup bravo1     172.16.128.133
  assert_reverse_lookup charlie1   172.16.128.134
  assert_reverse_lookup delta1     172.16.128.135
  assert_reverse_lookup echo1      172.16.128.136
}

@test 'Reverse lookups van interne servers uit VLAN 30.' {
  #                     hostname   IP
  assert_reverse_lookup kilo1      172.16.128.4
  assert_reverse_lookup lima1      172.16.128.5
  assert_reverse_lookup mike1      172.16.128.6
  assert_reverse_lookup november1  172.16.128.7
  assert_reverse_lookup oscar1     172.16.128.8
  assert_reverse_lookup papa1      172.16.128.9
  assert_reverse_lookup quebec1    172.16.128.10
}

@test 'Alias lookups public van publieke servers in VLAN 30.' {
  #                   alias      hostname  IP
  assert_alias_lookup ad         alfa1     172.16.128.132
  assert_alias_lookup ns1        bravo1    172.16.128.133
  assert_alias_lookup ns2        charlie1  172.16.128.134
  assert_alias_lookup mail       delta1    172.16.128.135
  assert_alias_lookup www        echo1     172.16.128.136
}

@test 'Alias lookups private servers uit VLAN 50.' {
  assert_alias_lookup dhcp       kilo1     172.16.128.4
  assert_alias_lookup files      lima1     172.16.128.5
  assert_alias_lookup cms        mike1     172.16.128.6
  assert_alias_lookup db         november1 172.16.128.7
  assert_alias_lookup mon        oscar1    172.16.128.8
  assert_alias_lookup pxe        papa1     172.16.128.9
  assert_alias_lookup dnsfwd     quebec1   172.16.128.10
}

@test 'Forward lookups van virtuele machines.' {
  #                     hostname   IP
  assert_forward_lookup virt1     172.16.128.130
  assert_forward_lookup virt2     172.16.128.131
  assert_forward_lookup virt3     172.16.128.2
  assert_forward_lookup virt4     172.16.128.3
}

@test 'Reverse lookups van virtuele machines.' {
  #                     hostname   IP
  assert_reverse_lookup virt1     172.16.128.130
  assert_reverse_lookup virt2     172.16.128.131
  assert_reverse_lookup virt3     172.16.128.2
  assert_reverse_lookup virt4     172.16.128.3
}
