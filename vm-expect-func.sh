#!/usr/bin/expect
set timeout 5
set host [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]

# connect via ssh
spawn ssh ${username}@$host
expect {
    "yes/no" {send "yes\r";exp_continue}
    "assword" {send "${password}\r"}
    timeout { exit 2 }
}

# list remote hostname
expect -re ".*
\$#
\$#
"
    send "hostname\r"
    sleep 1
    send "exit\r"
    expect eof
