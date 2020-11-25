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
    echo -e "\e[1;32mSuccess....\e[0m"
  *)
    echo -e "\e[1;31mFailure....\e[0m"
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
  echo -e "\e[1;31mUsage: $0 *******user|update|frontend|catalogue|mongodb*********\e[0m"
}
case $1 in
user)
  print "creating user"
  useradd -d /home/roboshop -m -s /bin/bash roboshop
  status_check
  print "Assinging password to the user"
  echo "sayeedmds" | passwd --stdin "$roboshop"
  status_check
  print "Assinging user to root privilleges"
  echo 'roboshop  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
  status_check
  print "Finish.."
  ;;
update)
  print "updating system"
  yum update -y
  status_check
  print "finish"
  ;;
mongodb)
  print "Installing mongodb server"
  echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
yum install mongodb.org -y
status_check
print "starting system services"
systemctl start mongodb
systemctl enable mongodb
status_check
print "finish...."
print "changing the ip"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongodb.conf
print "restarting mongodb server"
systemctl restart mongodb
print "downloading database"
curl -s -L -o /tmp/mongodb.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/e9218aed-a297-4945-9ddc-94156bd81427/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
cd /tmp
unzip mongodb.zip
mongo < catalogue.js
mongo < users.js
print "finish..."
;;
*)
  print "Invalidate options"
  print2
  ;;
esac
