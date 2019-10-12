ip6addresses=`ping6 -c 3 ff02::1%eth0 | grep icmp_seq=2 |  awk -F '[ \t]+|/' '{print $4}' |awk '{print substr($1, 1, length($1)-1)}'`
for i in $ip6addresses; do
   echo Host:  $i;
   ssh-copy-id $i;
done
