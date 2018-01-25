<?php
# Fill our vars and run on cli
# $ php -f db-connect-test.php

$dbname = 'echo1DB';
$dbuser = 'echo1';
$dbpass = 'echo1';
$dbhost = '172.16.128.7';

$connect = mysql_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
mysql_select_db($dbname) or die("Could not open the db '$dbname'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysql_query($test_query);

$tblCnt = 0;
while($tbl = mysql_fetch_array($result)) {
  $tblCnt++;
  #echo $tbl[0]."<br />\n";
}

if (!$tblCnt) {
  echo "fail\n";
} else {
  echo "succes\n";
}
