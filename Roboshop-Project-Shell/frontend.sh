path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh

  print_head "Install Nginx "
  yum install nginx -y  &>>$log_file
  func_exit_code $?
  print_head "Download frontend source code "
  curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>$log_file
  func_exit_code $?
  print_head "Remove html folder"
  rm -rf /usr/share/nginx/html/*   &>>$log_file
  func_exit_code $?
  print_head "change path to html "
  cd /usr/share/nginx/html  &>>$log_file
  func_exit_code $?
  print_head "unzip frontend folder "
  unzip /tmp/frontend.zip  &>>$log_file
  func_exit_code $?
  print_head "copy roboshop conf file"
  cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>>$log_file
  func_exit_code $?
  print_head "enable and start nginx "
  systemctl enable nginx  &>>$log_file
  systemctl start nginx  &>>$log_file
  systemctl restart nginx  &>>$log_file
  func_exit_code $?
