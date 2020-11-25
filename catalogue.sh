#!/bin/bash
user_id=$(id -u)
case $user_id in
0)
  ;;
*)
  echo -e "\e[1;31mYou should be root user to perform this step\e[0m"
  exit 1
  ;;
esac
status_check() {
  case $? in
  0)
  echo -e "\e[1;32mSuccess...\e[0m"
  ;;
  *)
  echo -e "\e[1;31mFailure....\e[0m"
  ;;
esac
}
print() {
  echo -e "\e[1;34m$1\e[0m"
}
print1() {
  echo -e "\e[1;33m$1\e[0m"
}
print2() {
  echo -e "\e[1;31mUsage: $0 ******user |update |frontend |catalogue | mongodb******\e[0m"
}
case $1 in
user)
print "Creating the user"
useradd -d /home/roboshop -m -s /bin/bash roboshop
status_check
print "generating password for user roboshop"
echo "$sayeedmds" | passwd "$roboshop" --stdin
status_check
print "Giving sudo permission to roboshop user"
echo 'roboshop ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
print1 "finish"
;;
update)
  print "updating system"
  yum update -y
  status_check
  print1 "finish...."
  ;;
catalogue)
  print "installing nodejs server"
  status_check
  print1 "finish......"
  ;;
*)
  print "Invalidate options"
  print2
  ;;
esac