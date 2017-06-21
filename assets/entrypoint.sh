#!/usr/bin/env bash  
  
set -e  
source /assets/colorecho  

#chown -R oracle:oinstall /install
  
if [ ! -d "/opt/oracle/app/product/11.2.0/dbhome_1" ]; then  
    echo_yellow "Database is not installed. Installing..."  
    /assets/install.sh  
fi  
  
su oracle -c "/assets/entrypoint_oracle.sh"  
