path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh

rabbitmq_user_pwd=$1
if [ -z "$rabbitmq_user_pwd" ]; then
  echo RabbitMQ Password is missing
  exit
  fi

print_head "Install YUM repo file "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>>$log_file
func_exit_code $?
print_head "Install erlang"
yum install erlang -y  &>>$log_file
func_exit_code $?
print_head "configure YUM repos for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>>$log_file
func_exit_code $?
print_head "Install rabbitmq server"
yum install rabbitmq-server -y  &>>$log_file
func_exit_code $?
print_head "Enable and start rabbitmq "
systemctl enable rabbitmq-server  &>>$log_file
systemctl start rabbitmq-server  &>>$log_file
func_exit_code $?
print_head "add application user and pwd"
rabbitmqctl add_user ${add_user} ${rabbitmq_user_pwd}  &>>$log_file
func_exit_code $?
print_head "Set permissions for application user "
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$log_file
func_exit_code $?
