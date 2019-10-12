ip6addresses=`ping6 -c 3 ff02::1%eth0 | grep icmp_seq=2 |  awk -F '[ \t]+|/' '{print $4}' | awk '{print substr($1, 1, length($1)-1)}'`
for i in $ip6addresses; do
   remote_ipv6="::1"
   remote_hostname=`ssh $i hostname`;
   hostrtrn=`echo $?`
   remote_ipv6=`ssh $i ip addr | grep inet6 | awk -F '[ \t]+|/' '{print $3}' | grep -v ^::1 | grep -v ^fe80`
   ipv6rtrn=`echo $?`
   touch newhosts
   if [ $ipv6rtrn ]; then
       echo $remote_hostname: $remote_ipv6
       echo $remote_ipv6 $remote_hostname >> newhosts
   fi
done
