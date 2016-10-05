#! /bin/sh
eval `dbus export koolproxy`

# stop first
if [ "$koolproxy_enable" == "1" ];then
	/koolshare/koolproxy/koolproxy.sh stop.sh
fi
# remove old files
rm -rf /koolshare/koolproxy/rule*

# copy new files
cd /tmp

if [ ! -f / /koolshare/koolproxy/data/user.txt ];then
	cp -rf /tmp/koolproxy/koolproxy /koolshare/
else
	mv /koolshare/koolproxy/data/user.txt /tmp/user.txt.tmp
	cp -rf /tmp/koolproxy/koolproxy /koolshare/
	mv /tmp/user.txt.tmp /koolshare/koolproxy/data/user.txt
fi

cp -rf /tmp/koolproxy/scripts/* /koolshare/scripts/
cp -rf /tmp/koolproxy/webs/* /koolshare/webs/
cp -rf /tmp/koolproxy/res/* /koolshare/res/
cp -rf /tmp/koolproxy/perp/koolproxy /koolshare/perp/
cd /
rm -rf /tmp/koolproxy* >/dev/null 2>&1

chmod 755 /koolshare/koolproxy/*
chmod 755 /koolshare/scripts/*
chmod 755 /koolshare/perp//koolproxy/*

if [ -z "$koolproxy_dbug" ];then
	dbus set koolproxy_dbug=1
fi

if [ -z "$koolproxy_policy" ];then
	dbus set koolproxy_policy=1
fi

if [ -z "$koolproxy_lan_control" ];then
	dbus set koolproxy_lan_control=0
fi

sleep 1
# start
if [ "$koolproxy_enable" == "1" ];then
	/koolshare/koolproxy/koolproxy.sh restart
fi


