#!/bin/bash
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
blue='\e[94m'
magenta='\e[95m'
cyan='\e[96m'
gray='\e[97m'
none='\e[0m'

function install_epel()
{
	yum -y install epel-release
	yum makecache
}
function install_rpm()
{
	yum -y install python3 make cmake valgrind gdb lrzsz iotop bzip2 htop iftop lsof unzip curl tree supervisor curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker git
}
function yum_update()
{
	yum update -y
}
function useradd_user()
{
	USERS=("main-project")
	PASS=cmbjxccwtn19
	for USER in ${USERS[@]}
	do
		USER_COUNT=`cat /etc/passwd | grep ${USER}: -c`
		if [ ${USER_COUNT} -ne 1 ]
		then
			useradd  ${USER}
			echo ${PASS}|passwd --stdin ${USER} 
			echo -e " ${green} 用户名 is ${USER} 和 密码 is ${PASS} ${none}"
		else
			echo -e " ${red} 用户名 已经存在 ${none}"
		fi
	done
}
function make_directories()
{
	USERS=("main-project")
	for USER in ${USERS[@]}
	do
		mkdir "/data/${USER}"
		chown -R ${USER}:${USER} "/data/${USER}"
		mkdir "/ssd/${USER}"
		chown -R ${USER}:${USER} "/ssd/${USER}"
	done
}

[[ $(id -u) != 0 ]] && echo -e "\n 哎呀!哎呀!这是啥操作呀……请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1
echo -e "${yellow} 开始安装 epel-release 并 makecache ${none}"
install_epel
echo -e "${yellow} 开始安装自定义软件包 ${none}"
install_rpm
echo -e "${yellow} 开始更新系统 ${none}"
yum_update
echo -e "${yellow} 开始创建用户 ${none}"
#useradd_user
echo -e "${yellow} 开始创建目录 ${none}"
#make_directories
echo -e "${yellow} 操作完成 ${none}"
