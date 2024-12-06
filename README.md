# Nixos config 

nmcli -terse -fields SIGNAL,ACTIVE d wifi | awk --field-separator ':' '{if($2=="yes")print$1}'
