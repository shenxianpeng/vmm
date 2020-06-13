#!/bin/bash

username=$1
password=$2
input_host=$3

vm_list=vm-list.txt

check_result=vm-check-result.log

rm -rf $check_result > /dev/null 2>&1 || true

if [ ! -z $3 ]; then
    # -x force PATTERN to match only whole lines
    grep -x $3 $vm_list
    if [ $? -eq 0 ]; then
        echo "$3 exits in $vm_list file"
    else
        echo "append add $3 to $vm_list"
        echo "$3" >> $vm_list
    fi
fi

t_count=0   # total hostname count
s_count=0   # success hostname count
f_count=0   # failed hostname count
f_list=()   # failed hostname list

while read -r line; do
    echo "host is $line"
    t_count=$(($t_count+1))
    # source vm-expect-func.sh
    ./vm-expect-func.sh $line $username $password
    if [ "$?" = 0 ]; then
        s_count=$(($s_count+1)) 
    else
        f_list+=("$line")
        f_count=$(($f_count+1))
    fi
done < $vm_list

touch $check_result

echo "#####################################################" >> $check_result
echo "######### VM login check via SSH results ############" >> $check_result
echo "#####################################################" >> $check_result
echo "#                                                   #" >> $check_result
echo "# Compelted (success) $s_count/$t_count (total) login vm check. #" >> $check_result

# if has failed, print failed hostname.
if [ $f_count -gt 0 ]; then
echo "#                                                   #" >> $check_result
echo "# Below $f_count host(s) login faied, need to check.      #" >> $check_result
echo "#                                                   #" >> $check_result
    for f_host in "${f_list[@]}"
    do
        echo "     $f_host " >> $check_result
    done
fi
echo "#                                                   #" >> $check_result
echo "#####################################################" >> $check_result
