path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
echo -e "\e[31m>>>>>> create mongo repo file <<<<<<<\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m>>>>>> Install mongodb <<<<<<<\e[0m"
yum install mongodb-org -y
echo -e "\e[31m>>>>>> Update listen address <<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
##Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
echo -e "\e[31m>>>>>> enable and restart mongod service <<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod

