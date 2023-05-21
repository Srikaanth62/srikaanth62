path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh

print_head "create mongo repo file"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo  &>>$log_file
func_exit_code $?
print_head "Install mongodb "
yum install mongodb-org -y  &>>$log_file
func_exit_code $?
print_head "Update listen address "
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf  &>>$log_file
func_exit_code $?
##Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
print_head "enable and restart mongod service "
systemctl enable mongod  &>>$log_file
systemctl restart mongod  &>>$log_file
func_exit_code $?

