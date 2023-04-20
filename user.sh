path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
echo -e "\e[34m>>>>>>>> Setup nodejs repo <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[34m>>>>>>>> Install nodejs <<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[34m>>>>>>>> Add application user <<<<<<<<<\e[0m"
useradd ${add_user}
echo -e "\e[34m>>>>>>> create app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[34m>>>>>>>> Download the application code <<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[34m>>>>>>>>> unzip user code file <<<<<<\e[0m"
unzip /tmp/user.zip
echo -e "\e[34m>>>>>>>> Install nodejs dependencies <<<<<<<<<\e[0m"
npm install
echo -e "\e[34m>>>>>>> copy user service <<<<<<<<\e[0m"
cp ${script_path}/user.service /etc/systemd/system/user.service
echo -e "\e[34m>>>>>>> load service <<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[34m>>>>>>> enable and start service <<<<<<<<\e[0m"
systemctl enable user
systemctl start user
echo -e "\e[34m>>>>>>> copy mongodb repo file <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m>>>>>>> Install mongodb client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>> load mongodb schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.srikaanth62.online </app/schema/user.js
echo -e "\e[34m>>>>>>> restart user service <<<<<<<<\e[0m"
systemctl restart user



