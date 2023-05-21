path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
mysql_root_pwd=$1
component=shipping
setup_schema=mysql
if [ -z "$mysql_root_pwd" ]; then
  echo My Sql password is missing
  exit
  fi
func_java
