#!/bin/bash
#///////////////////////////////////////////
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#oracle 12c single installation for centos 7
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#///////////////////////////////////////////
echo "install packages"
yum -y install binutils compat-libcap1 gcc gcc-c++ glibc glibc.i686 glibc-devel glibc.i686 ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++l7.i686 libstdc++-devel libstdc++-devel.i686 compat-libstdc++-33 compat-libstdc++-33.i686 libXi libXi.i686 libXtst libXtst.i686 make sysstat
echo "cofnig sysctl.conf"
MEMTOTAL=$(free -b | sed -n '2p' | awk '{print $2}')
SHMMAX=$(expr $MEMTOTAL / 2)
SHMMNI=4096
PAGESIZE=$(getconf PAGE_SIZE)
cat >> /etc/sysctl.conf << EOF
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmmax = $SHMMAX
kernel.shmall = `expr $SHMMAX / $PAGESIZE \* $SHMMNI / 16 `
kernel.shmmni = $SHMMNI
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
EOF

sysctl -p

echo "Create user and groups for Oracle Database service"
i=54321; for group in oinstall dba backupdba oper dgdba kmdba; do
groupadd -g $i $group; i=`expr $i + 1`
done
useradd -u 1200 -g oinstall -G dba,oper,backupdba,dgdba,kmdba -d /home/oracle oracle
echo oracle:oracle | chpasswd

echo "chown directory"
mkdir -p /u01/app/oracle
chown -R oracle:oinstall /u01/app
chmod -R 775 /u01

echo "config login"
cat > /etc/pam.d/login <<EOF
session    required     pam_limits.so
EOF

echo "config limits.conf"
cat >> /etc/security/limits.conf <<EOF
# add to the end
oracle  soft  nproc   2047
oracle  hard  nproc   16384
oracle  soft  nofile  1024
oracle  hard  nofile  65536
oracle  soft  stack   10240
oracle  hard  stack   32768
#12c
oracle  soft  memlock   10240
oracle  hard  memlock   32768
EOF


#安装GNOME桌面环境
echo "install gnome"
isinstallgnome=`rpm -qa | grep gnome |wc -l`
if [ "$isinstallgnome" -lt 0 ]; then
yum install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
fi

echo "config profile"
cat>> /etc/profile <<EOF
if [ $USER = "oracle" ]; then  
if [ $SHELL = "/bin/ksh" ]; then  
ulimit -p 16384  
ulimit -n 65536a  
else  
ulimit -u 16384 -n 65536  
fi  
fi
EOF  

echo "config bash_profile"
su oracle
cat >> ~/.bash_profile <<EOF
# add to the end

export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db1
export ORACLE_SID=ora12c
export PATH=$ORACLE_HOME/bin:$PATH:$HOME/bin
export EDITOR=/bin/vi
EOF
exit

echo "install triggervnc"
yum -y install tigervnc-server tigervnc
#在oracle用户下启动一个vncserver服务
#vncserver


