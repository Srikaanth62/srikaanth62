path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
if [ -z "$mysql_root_pwd" ]; then
  echo MySql password is missing
  exit
  fi

print_head "Disable sql 8 ver"
dnf module disable mysql -y  &>>$log_file
func_exit_code $?
print_head "Setup mysql repo file"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo  &>>$log_file
func_exit_code $?
print_head "Install sql server "
yum install mysql-community-server -y  &>>$log_file
func_exit_code $?
print_head "Enable and start service "
systemctl enable mysqld  &>>$log_file
systemctl start mysqld  &>>$log_file
func_exit_code $?
print_head "add application user and pwd "
mysql_secure_installation --set-root-pass ${mysql_root_pwd}  &>>$log_file
func_exit_code $?
print_head "Restart mysql"
systemctl restart mysqld  &>>$log_file
func_exit_code $?

