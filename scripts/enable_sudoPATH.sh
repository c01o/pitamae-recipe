#!/bin/sh
#http://stackoverflow.com/questions/323957/how-do-i-edit-etc-sudoers-from-a-script
if [ -z "$1" ]; then
  echo "Starting up visudo with this script as first parameter"
  export EDITOR=$0 && sudo -E visudo
else
  echo "Changing sudoers"
  echo "Defaults exempt_group=itamae" >> $1
fi
