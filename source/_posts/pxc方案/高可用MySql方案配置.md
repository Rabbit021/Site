title: 高可用MySql方案配置
categories: [mysql,pxc,docker]
date: 2020-01-07 18:27:11
tags: [mysql,pxc,docker]

---

# 前景说明

基于**Docker**，搭建高可用的**PXC**集群

**前置条件** 安装好Docker

## PXC集群创建



1. **镜像获取**

   ````shell
   docker pull percona/percona-xtradb-cluster
   docker tag percona/percona-xtradb-cluster pxc #用一个短一点儿名称，方便面后面用
   ````

   

2. **PXC集群的创建（步骤说明）**

   ```shell
   # 创建网络
   docker network create --subnet=172.18.0.0/16 net1  # 创建集群使用的网络
   
   # 创建数据卷
   docker volume create --name backup   #创建备份卷
   docker volume create --name v1     #为每个节点创建数据卷，我这有就弄个了三个节点
   docker volume create --name v2
   docker volume create --name v3
   
   #创建第一个节点
   docker run -d -p 3306:3306  \  #端口
   -e MYSQL_ROOT_PASSWORD=abc123456 \ #mysql的连接密码
   -e CLUSTER_NAME=cluster1 \       #集群的名称，注意:不要和镜像的名称一样(不然不成功)
   -e XTRABACKUP_PASSWORD=abc123456 \ #集群节点之间的通信密
   -v v1:/var/lib/mysql \           # 数据卷映射
   -v backup:/data \  #备份位置
   --privileged \     #开启授权
   --name=node1 \     #节点的名称
   --net=net1 \       #上文设置的网段
--ip 172.18.0.2 \  #指定一下Ip
   pxc                #镜像名称（重命名的）
   
   # 查看日志，看是否初始化完成,成功了再创建第二个
   docker logs -f node1   
   
   #创建第二节点，加入到第一个节点，大部分和第一个一样，注意标注的地方
   docker run -d -p 3307:3306 \
   -e MYSQL_ROOT_PASSWORD=abc123456 \ 
   -e CLUSTER_NAME=cluster1 \  
   -e XTRABACKUP_PASSWORD=abc123456 \
   -e CLUSTER_JOIN=node1 \  #第一个节点名称（需要加入的节点名称）
   -v v2:/var/lib/mysql \   #对应的数据卷名称
   -v backup:/data \      
   --privileged \
   --name=node2 \          #节点名称，注意不要重名
   --net=net1 \
   --ip 172.18.0.3 pxc
   
   # 重复上步，创建若干节点
   docker run -d -p 3308:3306 -e MYSQL_ROOT_PASSWORD=abc123456 -e CLUSTER_NAME=cluster1 -e XTRABACKUP_PASSWORD=abc123456 -e CLUSTER_JOIN=node1 -v v3:/var/lib/mysql --privileged --name=node3 --net=net1 --ip 172.18.0.4 pxc
   
   
   
   ```
   
3. **完成命令如下（记录一下）**

   ```shell
   docker pull percona/percona-xtradb-cluster
   docker tag percona/percona-xtradb-cluster pxc #用一个短一点儿名称，方便面后面用
   
   docker network create --subnet=172.18.0.0/16 net1 
   
   docker volume create --name backup   #创建备份卷
   
   #第一个
   docker volume create --name v1
   docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=abc123456 -e CLUSTER_NAME=cluster1 -e XTRABACKUP_PASSWORD=abc123456 -v v1:/var/lib/mysql -v backup:/data --privileged --name=node1 --net=net1 --ip 172.18.0.2 pxc
   
   #加入
   docker volume create --name v2
   docker run -d -p 3307:3306 -e MYSQL_ROOT_PASSWORD=abc123456 -e CLUSTER_NAME=cluster1 -e XTRABACKUP_PASSWORD=abc123456 -e CLUSTER_JOIN=node1 -v v2:/var/lib/mysql -v backup:/data --privileged --name=node2 --net=net1 --ip 172.18.0.3 pxc
   
   #加入
   docker volume create --name v3
   docker run -d -p 3308:3306 -e MYSQL_ROOT_PASSWORD=abc123456 -e CLUSTER_NAME=cluster1 -e XTRABACKUP_PASSWORD=abc123456 -e CLUSTER_JOIN=node1 -v v3:/var/lib/mysql --privileged --name=node3 --net=net1 --ip 172.18.0.4 pxc
   
   #加入
   docker volume create --name v4
   docker run -d -p 3309:3306 -e MYSQL_ROOT_PASSWORD=abc123456 -e CLUSTER_NAME=cluster1 -e XTRABACKUP_PASSWORD=abc123456 -e CLUSTER_JOIN=node1 -v v4:/var/lib/mysql --privileged --name=node4 --net=net1 --ip 172.18.0.5 pxc		
   ```


4.  **按照上述步骤创建四个节点之后，使用Navicat就可以连接上述四个数据库，每个数据库的中的操作都会同步到其他的节点，保证数据的强一致性。**

## HaProxy对myql做负载均衡

1. 获取镜像

   ```shell
   docker pull haproxy # 获取haproxy的镜像
   ```

3. 配置haproxy.cfg配置文件

    ```

    ```







