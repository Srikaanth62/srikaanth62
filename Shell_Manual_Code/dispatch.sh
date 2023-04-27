path=$(realpath "$0")
script_path+$(dirname "$path")
source $script_path/common.sh
echo -e "\e[32m>>>>>>>>> Install golang <<<<<<<<<<\e[0m"
yum install golang -y
echo -e "\e[32m>>>>>>>>>>Add application user<<<<<<<<\e[0m"
useradd ${add-user}
echo -e "\e[32m>>>>>>>>> create app directory <<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m>>>>>>>>> download application code <<<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
echo -e "\e[32m>>>>>>>>> unzip code file <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/dispatch.zip
echo -e "\e[32m>>>>>>>>> Install dependencies and build the applications <<<<<<<<<<\e[0m"
go mod init dispatch
go get
go build
echo -e "\e[32m>>>>>>>>> copy dispatch service <<<<<<<<<<\e[0m"
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[32m>>>>>>>>> load service <<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[32m>>>>>>>>> Enable and restart the service <<<<<<<<<<\e[0m"
systemctl enable dispatch
systemctl restart dispatch

