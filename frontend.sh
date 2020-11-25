#!/bin/bash
user_id=$(id -u)
case $user_id in
0)
  ;;
*)
  echo -e "\e[1;31mYou should be root user to perform\e[0m"
  exit 1
  ;;
esac
status_check() {
  case $? in
  0)
    echo -e "\e[1;32mSuccess...."
    ;;
  *)
    echo -e "\e[1;31mFailure....."
    exit 3
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
  echo -e "\e[1;31mUsage: $0 ******update | frontend | catalogue | mongodb******\e[0m"
}
case $1 in
update)
  print "Updating system"
  yum update -y
  status_check
  print1 "Finish..."
  ;;
frontend)
  print "Installing nginx server"
  status_check
  print1 "Finish...."
  ;;
catalogue)
  print "Installing nodejs server"
  status_check
  print1 "Finish....."
  ;;
mongodb)
  print "Installing mongodb server"
  status_check
  print1 "Finish......"
  ;;
*)
  print "Invalidate options"
  print2
  exit 2
  ;;
esac
