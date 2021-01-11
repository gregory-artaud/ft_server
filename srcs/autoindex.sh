#!/bin/bash
if [ $# -eq 1 ]
then
	if [ $1 = "off" ]
	then
			cp /app/srcs/nginx_config/default_indexoff /etc/nginx/sites-available/default
			service nginx restart
	else if [ $1 = "on" ]
	then
			cp /app/srcs/nginx_config/default /etc/nginx/sites-available/default
			service nginx restart
	else
			echo "Invalid argument, please enter 'on' or 'off'"
	fi
	fi
else
	echo "Script only need one argument, please enter 'on' or 'off'"
fi