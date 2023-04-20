path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
echo -e "\e[35m>>>>>>> Setup nodejs repos <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>> Install nodejs <<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>> add application user <<<<<<<<<<<\e[0m"
useradd ${add_user}
echo -e "\e[35m>>>>>> create app directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>> Download the application code <<<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[35m>>>>>> unzip code file <<<<<<<<<<<\e[0m"
unzip /tmp/cart.zip
echo -e "\e[35m>>>>>> Install dependencies <<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>> copy cart service file <<<<<<<<<<<\e[0m"
cp $script_path/cart.service /etc/systemd/system/cart.service
echo -e "\e[35m>>>>>> load service <<<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[35m>>>>>> Enable and start service <<<<<<<<<<<\e[0m"
systemctl enable cart
systemctl restart cart




