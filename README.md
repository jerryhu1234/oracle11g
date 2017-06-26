# oracle11g
docker install oracle11g
CentOS7中的安全模块selinux把权限禁掉
临时关闭selinux：
   setenforce 0
使用oracle11g的静默安装
保用数据库responfile目录下的rsp文件，进行相应修改，进行安装。
install目录下放oracle11g解压后的文件


├── assets
│   ├── colorecho
│   ├── dbca.rsp   --数据库安装文件
│   ├── db_install.rsp --数据库管理系统安装文件
│   ├── entrypoint_oracle.sh --数据安装执行shell
│   ├── entrypoint.sh  --cmd入口文件
│   ├── install.sh  
│   ├── limits.conf
│   ├── profile
│   ├── run_installer.sh
│   ├── setup.sh  --数据库安装前准备环境
│   ├── sysctl.conf
|   └── netca.rsp  ---数据库监听安装文件
├── build.sh  --创建o11g镜像
├── Dockerfile docker 入口文件
├── install  
└── run.sh  ---创建11g容器
