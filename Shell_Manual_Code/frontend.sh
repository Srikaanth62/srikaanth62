path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
echo -e "\e[33m>>>>>>> Install Nginx <<<<<<<<<\e[0m"
yum install nginx -y
echo -e "\e[33m>>>>>>> Download frontend source code <<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[33m>>>>>>> Remove html folder <<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[33m>>>>>>> change path to html <<<<<<<<\e[0m"
cd /usr/share/nginx/html
echo -e "\e[33m>>>>>>> unzip frontend folder <<<<<<<\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[33m>>>>>> copy roboshop conf file <<<<<<<\e[0m"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m>>>>>> enable and start nginx <<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx

