# oracle11g
docker install oracle11g
CentOS7中的安全模块selinux把权限禁掉
临时关闭selinux：
   setenforce 0
使用oracle11g的静默安装
保用数据库responfile目录下的rsp文件，进行相应修改，进行安装。

├── assets
│   ├── colorecho
│   ├── dbca.rsp
│   ├── db_install.rsp
│   ├── entrypoint_oracle.sh
│   ├── entrypoint.sh
│   ├── install.sh
│   ├── limits.conf
│   ├── profile
│   ├── run_installer.sh
│   ├── setup.sh
│   ├── sysctl.conf
|   └── netca.rsp 
├── build.sh
├── Dockerfile
└── run.sh
