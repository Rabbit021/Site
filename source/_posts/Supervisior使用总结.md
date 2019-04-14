title: Supervisior使用总结
date: 2019-04-04 13:29:46
tags: supervisor

categories: [ CLR ,C# , Net]

---

Supervisiors是用python编写的linux下一款进程控制软件，控制进程的开启，停止，重启操作,可以自动重启异常中断的服务。可以通过配置webserver实现web端对服务的监控。

## Supervisior安装

## 系统环境:
  - 操作系统：Ubuntu 16.04.6 LTS
  - Python： 2.7.12

1. 使用使用pip安装：（貌似可以安装最新的）

   需要安装有python环境，和pip

   ```shell
   sudo pip install supervisior
   ```

2. 使用apt-get或者apt安装（发布包版本,***推荐的安装方式***）

   ```shell
   sudo apt-cache show supervisor 查看supervisor的版本信息
   sudo apt install supervisor
   或者
   sudo apt-get install supervisor
   ```

   

## Supervisior配置

supervisor安装完成之后，可以使用`echo_supervisord_conf`创建配置文件。

```shell
sudo mkdir /etc/supervisor #创建配置文件的文件夹
sudo echo_supervisord_conf > /etc/supervisor/supervisord.conf # 创建配置文件
sudo supervisord -c /etc/supervisor/supervisord.conf # 指定配置文件启动
```

配置文件说明 ：

1. `[unix_http_server]`

   ```ini
   [unix_http_server]
   file=/tmp/supervisor.sock   ; the path to the socket file
   ;chmod=0700                 ; socket file mode (default 0700)
   ;chown=nobody:nogroup       ; socket file uid:gid owner
   ;username=user              ; default is no username (open server)
   ;password=123               ; default is no password (open server)
   ```



| file     | /tmp/supervisor.sock | 不是必须的 |
| -------- | -------------------- | ---------- |
| chmod    | 0777                 | 不是必须的 |
| 属性     | 属性值               | 说明       |
| chown    | nobody:nogroup       | 不是必须的 |
| username | user                 | 不是必须的 |
| password | 123                  | 不是必须的 |

2. `[inet_http_server]` 可以配置http服务，可以通过通过web服务来控制服务的启动

   ```ini
   ;[inet_http_server]         ; inet (TCP) server disabled by default
   ;port=127.0.0.1:9001        ; ip_address:port specifier, *:port for all iface
   ;username=user              ; default is no username (open server)
   ;password=123               ; default is no password (open server)
   
   ```



| 属性     | 属性值               | 说明             |
| -------- | -------------------- | ---------------- |
| port     | /tmp/supervisor.sock | 访问的地址       |
| username | user                 | 授权的用户和密码 |
| password | 123                  | 授权的用户和密码 |
3. `[include]` 设备

   ```ini
   files=自定义服务的路径 （program配置放置的位置）
   例如：
   files=/etc/supervisor/conf.d/*.conf 
   ```

4. web管理方式的配置：(配置之前备份一下配置文件`cp supervisord.conf supervisord.conf.bak`)



   ```ini
   [inet_http_server]
   port=ip:9001      #配置ip或者*
   ```





## Supervisior使用

添加一个**progam**，在上述的路径 `/etc/supervisor/conf.d/`（自己配置的**files**位置）创建conf文件

```sh
cd /etc/supervisor/conf.d
touch test.conf
vi test.conf
## 编辑test.conf
[program:XXX]   #服务命令 
command=command #命令
user=ubuntu		
autorestart=true 

## 
sudo supervisorctl update #更新一下配置的服务
sudo supervisorctl status #可以看服务的运行状态了
sudo supervisorctl start XX （stop XX） 开始或者关闭服务
```

