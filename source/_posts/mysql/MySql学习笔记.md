

# MySql学习笔记

## 安装配置

### docker下的安装

**注意点**需要指定root的密码

```shell
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7  //没有做端口映射
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7 //指定端口
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
-v /opt/mysqldata:/var/lib/mysql mysql:5.7 // 映射数据存储目录
```

安装mysql示例数据库：https://github.com/datacharmer/test_db

```
docker cp ./test_master containerId:/opt/sample // 拷贝文件到docker容器 
```



## 主从复制



## MySql索引

EXPLAIN结果说明


<table class="a164" border="1" cellspacing="0" cellpadding="0">
<tbody>
<tr><th>列名</th><th>类型</th><th>解释</th></tr>
<tr>
<td>id</td>
<td>&nbsp;</td>
<td>SELECT语句的ID编号,优先执行编号较大的查询,如果编号相同,则从上向下执行</td>
</tr>
<tr>
<td rowspan="8">select_type</td>
<td>SIMPLE</td>
<td>一条没有UNION或子查询部分的SELECT语句</td>
</tr>
<tr>
<td>PIMARY</td>
<td>最外层或最左侧的SELECT语句</td>
</tr>
<tr>
<td>UNION</td>
<td>UNION语句里的第二条或最后一条SELECT语句</td>
</tr>
<tr>
<td>DEPENDENT UNION</td>
<td>和UNION类型的含义相似,但需要依赖于某个外层查询</td>
</tr>
<tr>
<td>UNION RESULT</td>
<td>一条UNION语句的结果</td>
</tr>
<tr>
<td>SUBQUERY</td>
<td>子查询中的第一个SELECT子句</td>
</tr>
<tr>
<td>DEPENDENT SUBQUERY</td>
<td>和SUBQUERY类型的含义相似,但需要依赖于某个外层查询</td>
</tr>
<tr>
<td>DERIVED</td>
<td>FROM子句里的子查询</td>
</tr>
<tr>
<td>table</td>
<td>t1</td>
<td>各输出行里的信息是关于哪个数据表的</td>
</tr>
<tr>
<td>Partitions</td>
<td>NULL</td>
<td>将要使用的分区.只有EXPLAIN PARTITIONS ...语句才会显示这一列.非分区表显示为NULL</td>
</tr>
<tr>
<td rowspan="12">type</td>
<td>&nbsp;</td>
<td>联接操作的类型,性能由好到差依次如下</td>
</tr>
<tr>
<td>system</td>
<td>表中仅有一行</td>
</tr>
<tr>
<td>const</td>
<td>单表中最多有一个匹配行</td>
</tr>
<tr>
<td>eq_ref</td>
<td>联接查询中,对于前表的每一行,在此表中只查询一条记录,使用了PRIMARY或UNIQUE</td>
</tr>
<tr>
<td>ref</td>
<td>联接查询中,对于前表的每一行,在此表中只查询一条记录,使用了INDEX</td>
</tr>
<tr>
<td>ref_or_null</td>
<td>联接查询中,对于前表的每一行,在此表中只查询一条记录,使用了INDEX,但是条件中有NULL值查询</td>
</tr>
<tr>
<td>index_merge</td>
<td>多个索引合并</td>
</tr>
<tr>
<td>unique_subquery</td>
<td>举例说明: value IN (SELECT primary_key FROM single_table WHERE some_expr)</td>
</tr>
<tr>
<td>index_subquery</td>
<td>举例说明: value IN (SELECT key_column FROM single_table WHERE some_expr)</td>
</tr>
<tr>
<td>range</td>
<td>只检索给定范围的行,包括如下操作符: =, &lt;&gt;, &gt;, &gt;=, &lt;, &lt;=, IS NULL, &lt;=&gt;, BETWEEN, or IN()</td>
</tr>
<tr>
<td>index</td>
<td>扫描索引树(略比ALL快,因为索引文件通常比数据文件小)</td>
</tr>
<tr>
<td>ALL</td>
<td>前表的每一行数据都要跟此表匹配,全表扫描</td>
</tr>
<tr>
<td>possible_keys</td>
<td>NULL</td>
<td>MySQL认为在可能会用到的索引.NULL表示没有找到索引</td>
</tr>
<tr>
<td>key</td>
<td>NULL</td>
<td>检索时,实际用到的索引名称.如果用了index_merge联接类型,此时会列出多个索引名称,NULL表示没有找到索引</td>
</tr>
<tr>
<td>key_len</td>
<td>NULL</td>
<td>实际使用的索引的长度.如果是复合索引,那么只显示使用的最左前缀的大小</td>
</tr>
<tr>
<td>ref</td>
<td>NULL</td>
<td>MySQL用来与索引值比较的值, 如果是单词const或者???,则表示比较对象是一个常数.如果是某个数据列的名称,则表示比较操作是逐个数据列进行的.NULL表示没有使用索引</td>
</tr>
<tr>
<td>rows</td>
<td>&nbsp;</td>
<td>MySQL为完成查询而需要在数据表里检查的行数的估算值.这个输出列里所有的值的乘积就是必须检查的数据行的各种可能组合的估算值</td>
</tr>
<tr>
<td rowspan="4">Extra</td>
<td>Using filesort</td>
<td>需要将索引值写到文件中并且排序,这样按顺序检索相关数据行</td>
</tr>
<tr>
<td>Using index</td>
<td>MySQL可以不必检查数据文件, 只使用索引信息就能检索数据表信息</td>
</tr>
<tr>
<td>Using temporary</td>
<td>在使用 GROUP BY 或 ORDER BY 时,需要创建临时表,保存中间结果集</td>
</tr>
<tr>
<td>Using where</td>
<td>利用SELECT语句中的WHERE子句里的条件进行检索操作</td>
</tr>
</tbody>
</table>


### Mysql扫描行数估算

1. 使用**SHOW INDEX FROM tb_index**可以查看index的索引统计值，刚更新行数超过**1/M**则会重新估算，可以使用**analyze table**重新估算 ，可以通过设置innodb_stats_persistent，修改重新统计的比例.

![image-20200311175523351](\source\img\mysql\showindex.png)

### 组合索引(clustered index)

1. 复合最左原则，例如  Key （A，B, C）一下会走索引 A | A,B |A,B,C这些走索引
2. Where中使用OR是不走索引的，**如果符合索引覆盖(主键索引一样)，会走做索引树扫描，explain里体现为type为Index**,例如:**表 tb 有 a,b,c三列 ，Index（a,b,c）, select a from tb where b=xxx 则会遍历索引树，知道符合查找条件为止**
3. 索引有长度限制：好像是单列索引255个字符

### Mysql排序

```sql
-- 创建表

CREATE TABLE `person` (
	`id` INT ( 11 ) NOT NULL,
	`city` VARCHAR ( 16 ) NOT NULL,
	`name` VARCHAR ( 16 ) NOT NULL,
	`age` INT ( 11 ) NOT NULL,
	`addr` VARCHAR ( 128 ) DEFAULT NULL,
	PRIMARY KEY ( `id` ),
KEY `city` ( `city` ) 
) ENGINE = INNODB;

SHOW  VARIABLES like 'sort_buffer_size'; // 用于排序内存大小

// 全字段排序
select city,name,age from person where city='杭州' order by name limit 1000;


// RowI排序
// 控制用于排序的行数据的长度的一个参数，先排序，找到主键Id，然后再去取记录
SET max_length_for_sort_data = 16; 

```





