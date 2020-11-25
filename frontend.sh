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
  yum install nginx -y
  status_check
  print "Starting nginx service"
  systemctl start nginx
  systemctl enable nginx
  print "Downloading the source code"
  curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/db389ddc-b576-4fd9-be14-b373d943d6ee/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
  status_check
  cd /usr/share/nginx/html
  rm -rf  *
  unzip /tmp/frontend.zip
  mv static/* .
  rm -rf static README.md
  mv localhost.conf /etc/nginx/nginx.conf
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
