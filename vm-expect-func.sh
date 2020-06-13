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
}

# list remote hostname
expect -re ".*
\$#
\$#
"
    send "hostname\r"
    send "exit\r"
    expect eof
