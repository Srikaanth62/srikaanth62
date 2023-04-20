path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
echo -e "\e[32m>>>>>>> Setup nodejs repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m>>>>>>> Install Nodejs <<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[32m>>>>>>> add application user <<<<<<<\e[0m"
useradd ${add_user}
echo -e "\e[32m>>>>>> create app directory <<<<<<\e[0m"
mkdir /app
echo -e "\e[32m>>>>>> download application code <<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[32m>>>>>> unzip application code <<<<<<<\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[32m>>>>>>>> Install nodejs dependencies <<<<<<<<\e[0m"
npm install
echo -e "\e[32m>>>>>>>> copy catalogue service file <<<<<<<<\e[0m"
cp $script_path/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m>>>>>> load the service <<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[32m>>>>>>> Enable and start the service <<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[32m>>>>>> copy and Setup mongodb repo <<<<<<<\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m>>>>>>>>> Install mongodb client <<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[32m>>>>>>>>>> load schema <<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.srikaanth62.online </app/schema/catalogue.js
echo -e "\e[32m>>>>>>>>>> Restart the catalogue service <<<<<<<<<\e[0m"
systemctl restart catalogue
