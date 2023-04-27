path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
print_head Install java packaging softwareprint_head
yum install maven -y
print_head create application user<<<<<<<<<\e[0m"
useradd ${add_user}
print_head craete app directoryprint_head
rm -rf /app
mkdir /app
print_head Download application code <<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
print_head unzip code fileprint_head
unzip /tmp/shipping.zip
print_head download dependencies and build the applications<<<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
print_head copy shipping service print_head
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
print_head Load service <<<<<<<<<\e[0m"
systemctl daemon-reload
print_head Enable and start the service print_head
systemctl enable shipping
systemctl start shipping
print_head Install sql client <<<<<<<<<\e[0m"
yum install mysql -y
print_head Load the sql schema print_head
mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/shipping.sql
print_head Restart the service <<<<<<<<<\e[0m"
systemctl restart shipping