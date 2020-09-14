store_ip_on='last_ip.txt'
adb tcpip 5555
if [ $? == 0 ]; then #If adb tcpip is successfull, try to connect to device
    if [ -f $store_ip_on ]; then 
        read -p 'Try to connect to last used IP address? (y/n): ' connect_var
        if [ $connect_var == 'y' ]; then
            while read ip; do
                if [ ! -z $ip ]; then
                    connect_ip=$ip
                fi
            done < $store_ip_on
        fi
    fi
    while [ -z $connect_ip ]; do
        read -p 'Please type the IP address: ' connect_ip
    done
    adb connect $connect_ip
    echo $connect_ip > $store_ip_on
    if [ ! -f $store_ip_on ]; then
        echo 'Failed to save IP address! please check file and folder permissions'
    fi
fi