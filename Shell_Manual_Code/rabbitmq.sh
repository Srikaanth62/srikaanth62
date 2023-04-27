path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
rabbitmq_user_pwd=$1
echo -e "\e[32m>>>>>>>>> Install YUM repo file <<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[32m>>>>>>>> Install erlang <<<<<<<<<<<<<<\e[0m"
yum install erlang -y
echo -e "\e[32m>>>>>>>> configure YUM repos for rabbitmq <<<<<<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[32m>>>>>>>> Install rabbitmq server <<<<<<<<<<<<<<\e[0m"
yum install rabbitmq-server -y
echo -e "\e[32m>>>>>>>> Enable and start rabbitmq <<<<<<<<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[32m>>>>>>>> add application user and pwd <<<<<<<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_user_pwd}
echo -e "\e[32m>>>>>>>> Set permissions for application user <<<<<<<<<<<<<<\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
