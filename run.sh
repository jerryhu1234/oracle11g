docker rm -f oracle11g  
docker run --name oracle11g -p 1521:1521 -v /root/oracle11g/install:/install/database jerryhu/oracle11g  
