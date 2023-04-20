path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
echo -e "\e[32m>>>>>>>> Install python 3.6 <<<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[32m>>>>>>>> add application user<<<<<<<<<<<\e[0m"
useradd ${add_user}
echo -e "\e[32m>>>>>>>> create app directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m>>>>>>>> download application code <<<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[32m>>>>>>>> unzip code file <<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip
echo -e "\e[32m>>>>>>>> Download and Install dependencies <<<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[32m>>>>>>>> copy payment service file <<<<<<<<<<<\e[0m"
sed -i -e "s|rabbitmq_user_pwd|${rabbitmq_user_pwd}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service
echo -e "\e[32m>>>>>>>> load, enable and restart the service <<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

