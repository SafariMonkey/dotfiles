#! /bin/bash

cat /dev/urandom | tr -dc ' -~' | head -c3200 | sed -e "s/.\{80\}/&\n/g"
echo
