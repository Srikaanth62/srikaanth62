#!/bin/bash
add_user=roboshop
log_file=/tmp/roboshop.log
print_head() {
  echo -e "\e[36m>>>>>>> $1 <<<<<<<<<<<<<\e[0m"
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m" &>>$log_file
}

func_exit_code() {
  if [ $1 -eq 0 ]; then
      echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31mFAILURE\e[0m"
      echo "Please refer following path to check failures : /tmp/roboshop.log"
      exit
    fi
}

func_app_user() {
    print_head "create application user"
    id ${add_user} &>>/tmp/roboshop.log
    if [ $? -ne 0 ]; then
    useradd ${add_user}  &>>/tmp/roboshop.log
    fi
    func_exit_code $?
    print_head "create app directory"
    rm -rf /app  &>>$log_file
    mkdir /app  &>>$log_file
    func_exit_code $?
    print_head "Download application code"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
    func_exit_code $?
    cd /app  &>>$log_file
    print_head "unzip code file"
    unzip /tmp/${component}.zip  &>>$log_file
    func_exit_code $?
}

func_setup_schema() {
  if [ "$setup_schema" == "mongo" ]; then
  print_head "copy and Setup mongodb repo "
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo  &>>$log_file
  func_exit_code $?
  print_head  "Install mongodb client"
  yum install mongodb-org-shell -y  &>>$log_file
  func_exit_code $?
  print_head "load mongodb schema "
  mongo --host mongodb-dev.srikaanth62.online  </app/schema/${component}.js  &>>$log_file
  func_exit_code $?
fi

  if [ "$setup_schema" == "mysql" ]; then
     print_head "Install sql client"
     yum install mysql -y  &>>$log_file
     func_exit_code $?
     print_head "Load the sql schema"
     mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/${component}.sql  &>>$log_file
     func_exit_code $?
  fi
 }

 func_systemd_setup() {
   print_head "copy systemd service"
   cp $script_path/${component}.service /etc/systemd/system/${component}.service  &>>$log_file
   func_exit_code $?
   print_head "Load service"
   systemctl daemon-reload &>>$log_file
   func_exit_code $?
   print_head "Enable and start the service"
   systemctl enable ${component}  &>>$log_file
   systemctl start ${component}  &>>$log_file
   func_exit_code $?
   print_head "Restart the service"
   systemctl restart ${component}  &>>$log_file
   func_exit_code $?
 }

func_nodejs() {
  print_head "Setup nodejs repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  func_exit_code $?
  print_head "Install nodejs"
  yum install nodejs -y  &>>$log_file
  func_exit_code $?
  func_app_user
  print_head "Install dependencies "
  npm install  &>>$log_file
  func_exit_code $?
  func_setup_schema
  func_systemd_setup

}

func_java() {
  print_head "Install java packaging software"
  yum install maven -y  &>>$log_file
  func_exit_code $?
  func_app_user
  print_head "download dependencies and build the application"
  mvn clean package  &>>$log_file
  mv target/${component}-1.0.jar ${component}.jar &>>$log_file
  func_exit_code $?
  func_setup_schema
  func_systemd_setup
}

func_golang() {
  print_head "Install golang "
  yum install golang -y  &>>$log_file
  func_exit_code $?
  func_app_user
  print_head "Install and build golang dependencies "
  go mod init ${component}  &>>$log_file
  go get  &>>$log_file
  go build  &>>$log_file
  func_exit_code $?
  func_systemd_setup
}

func_python() {
  print_head "Install python 3.6 "
  yum install python36 gcc python3-devel -y  &>>$log_file
  func_exit_code $?
  func_app_user
  print_head "Download and Install dependencies"
  pip3.6 install -r requirements.txt  &>>$log_file
  func_exit_code $?
  print_head "set rabbitmq pwd file"
  sed -i -e "s|rabbitmq_user_pwd|${rabbitmq_user_pwd}|" ${script_path}/${component}.service  &>>$log_file
  func_exit_code $?
  func_systemd_setup
}


