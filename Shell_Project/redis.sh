path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh

print_head "Install redis repo file "
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>$log_file
func_exit_code $?
print_head "Enable Redis 6.2 from package streams "
dnf module enable redis:remi-6.2 -y  &>>$log_file
func_exit_code $?
print_head "Install redis "
yum install redis -y  &>>$log_file
func_exit_code $?
print_head "update listen address "
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf  &>>$log_file
func_exit_code $?
## Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf
print_head "Enable and restart the redis service"
systemctl enable redis  &>>$log_file
systemctl start redis  &>>$log_file
systemctl restart redis  &>>$log_file
func_exit_code $?


