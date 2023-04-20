path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
echo -e "\e[31m>>>>>>>>>>> Install java packaging software<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[31m>>>>>>>>>> create application user<<<<<<<<<\e[0m"
useradd ${add_user}
echo -e "\e[31m>>>>>>>>>> craete app directory<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[31m>>>>>>>>>> Download application code <<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[31m>>>>>>>>>> unzip code file<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[31m>>>>>>>>>> download dependencies and build the applications<<<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[31m>>>>>>>>>> copy shipping service <<<<<<<<<\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[31m>>>>>>>>>> Load service <<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[31m>>>>>>>>>> Enable and start the service <<<<<<<<<\e[0m"
systemctl enable shipping
systemctl start shipping
echo -e "\e[31m>>>>>>>>>> Install sql client <<<<<<<<<\e[0m"
yum install mysql -y
echo -e "\e[31m>>>>>>>>>> Load the sql schema <<<<<<<<<\e[0m"
mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/shipping.sql
echo -e "\e[31m>>>>>>>>>> Restart the service <<<<<<<<<\e[0m"
systemctl restart shipping