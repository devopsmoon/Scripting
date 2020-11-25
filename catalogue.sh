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
  yum install nodejs gcc-c++ make -y
  status_check
  print "Downloading source code "
  curl -s -L -o /tmp/catalogue.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/558568c8-174a-4076-af6c-51bf129e93bb/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
  status_check
  cd /home/roboshop
  mkdir catalogue
  cd catalogue
  unzip /tmp/catalogue
  unzip -o /tmp/catalogue.zip
  status_check
  npm install
  print1 "finish......"
  ;;
*)
  print "Invalidate options"
  print2
  ;;
esac