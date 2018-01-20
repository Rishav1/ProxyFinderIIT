#!/bin/bash

echo "
base {
	log_debug = off;
	log_info = off;
	log = debug;
	daemon = off;
	redirector = iptables;
}
redsocks {
	local_ip = 0.0.0.0;
	local_port = 8123;
	ip = $1;
	port = $2;
	type = http-relay;
	login = \"$3\";
	password = \"$4\";
}
redsocks {
	local_ip = 0.0.0.0;
	local_port = 8124;
	ip = $1;
	port = $2;
	type = http-connect;
	login = \"$3\";
	password = \"$4\";
}
" | sudo tee /etc/iitg-acproxy/config/redsocksauto.conf
