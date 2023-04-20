path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
echo -e "\e[36m>>>>>>>> Disable sql 8 ver<<<<<<<<<\e[0m"
dnf module disable mysql -y
echo -e "\e[36m>>>>>>>> Setup mysql repo file<<<<<<<<\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>> Install sql server <<<<<<<<<<<\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m>>>>>>>> Enable and start service <<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[36m>>>>>>>> add application user and pwd <<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass ${mysql_root_pwd}
echo -e "\e[36m>>>>>>>> Restart my sql  <<<<<<<<\e[0m"
systemctl restart mysqld

