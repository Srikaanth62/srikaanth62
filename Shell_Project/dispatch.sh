path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
rabbitmq_user_pwd=$1
if [ -z "$rabbitmq_user_pwd" ]; then
  echo RabbitMQ Password is missing
  exit
  fi
component=dispatch
func_golang

