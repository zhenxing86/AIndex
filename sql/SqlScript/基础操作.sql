--主键约束
SELECT
  tab.name AS [表名],
  idx.name AS [主键名称],
  col.name AS [主键列名]
FROM
  sys.indexes idx
    JOIN sys.index_columns idxCol 
      ON (idx.object_id = idxCol.object_id 
          AND idx.index_id = idxCol.index_id 
          AND idx.is_primary_key = 1)
    JOIN sys.tables tab
      ON (idx.object_id = tab.object_id)
    JOIN sys.columns col
      ON (idx.object_id = col.object_id
          AND idxCol.column_id = col.column_id)
      where tab.name='stu_mc_day'

--唯一约束
SELECT
  tab.name AS [表名],
  idx.name AS [约束名称],
  col.name AS [约束列名]
FROM
  sys.indexes idx
    JOIN sys.index_columns idxCol 
      ON (idx.object_id = idxCol.object_id 
          AND idx.index_id = idxCol.index_id 
          AND idx.is_unique_constraint = 1)
    JOIN sys.tables tab
      ON (idx.object_id = tab.object_id)
    JOIN sys.columns col
      ON (idx.object_id = col.object_id
          AND idxCol.column_id = col.column_id)
    where tab.name='stu_mc_day'

--外键约束
select 
  oSub.name  AS  [子表名称],
  fk.name AS  [外键名称],
  SubCol.name AS [子表列名],
  oMain.name  AS  [主表名称],
  MainCol.name AS [主表列名]
from 
  sys.foreign_keys fk  
    JOIN sys.all_objects oSub  
        ON (fk.parent_object_id = oSub.object_id)
    JOIN sys.all_objects oMain 
        ON (fk.referenced_object_id = oMain.object_id)
    JOIN sys.foreign_key_columns fkCols 
        ON (fk.object_id = fkCols.constraint_object_id)
    JOIN sys.columns SubCol 
        ON (oSub.object_id = SubCol.object_id  
            AND fkCols.parent_column_id = SubCol.column_id)
    JOIN sys.columns MainCol 
        ON (oMain.object_id = MainCol.object_id  
            AND fkCols.referenced_column_id = MainCol.column_id)
   where oMain.name='stu_mc_day'

--Check约束
SELECT
  tab.name AS [表名],
  chk.name AS [Check约束名],
  col.name AS [列名],
  chk.definition
FROM
  sys.check_constraints chk
    JOIN sys.tables tab
      ON (chk.parent_object_id = tab.object_id)
    JOIN sys.columns col
      ON (chk.parent_object_id = col.object_id
          AND chk.parent_column_id = col.column_id)
 where tab.name='stu_mc_day'

--获取表名及表的触发器
select 
   b.name as 表名,a.name  as 触发器 
   from sysobjects  as a 
    inner join sysobjects as b on b.id = a.parent_obj
   where a.xtype='TR'
   --and b.name='stu_mc_day'
order by b.name

备注：
 xtype   char(2)   对象类型。可以是下列对象类型中的一种：     
  C   =   CHECK   约束   
  D   =   默认值或   DEFAULT   约束   
  F   =   FOREIGN   KEY   约束   
  L   =   日志   
  FN   =   标量函数   
  IF   =   内嵌表函数   
  P   =   存储过程   
  PK   =   PRIMARY   KEY   约束（类型是   K）   
  RF   =   复制筛选存储过程   
  S   =   系统表   
  TF   =   表函数   
  TR   =   触发器   
  U   =   用户表   
  UQ   =   UNIQUE   约束（类型是   K）   
  V   =   视图   
  X   =   扩展存储过程  


-- 修改表字段长度
--alter table <表名> alter column <字段名> 新类型名(长度)

use BasicData
alter table verify_sms alter column account nvarchar(50)
alter table verify_sms alter column verify_code nvarchar(500)
alter table and_notice_batch alter column smscontent varchar(4000)

alter table [device_version] drop column kid

-- 尽量少用循环，改为序列
select CONVERT(VARCHAR(10),dateadd(dd,n,getdate()),120) 
from BasicData..nums1Q
WHERE N <= DATEDIFF(DD,'2013-06-21','2013-06-25')


alter table [device_version] add publish_type int
alter table [device_version] drop column kid


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'版本类型：-1 废弃版，0：测试版，1：稳定版' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'device_version', @level2type=N'COLUMN',@level2name=N'publish_type'
GO

ALTER TABLE [dbo].[kindergarten] ADD  CONSTRAINT [DF__kin__hx_sendtime]  DEFAULT ((0)) FOR [hx_sendtime]

alter table T_ping drop constraint DF_T_ping_p_c  
alter table T_ping add constraint DF_T_ping_p_c DEFAULT ((2)) for p_c 

select b.text as '默认值字段名 （随便起）',*  
from syscolumns a left join syscomments b on a.cdefault=b.id   
where a.id=object_id('kindergarten') and a.name='hx_sendtime' 


EXEC sp_helptext 'user_delete_ly'
EXEC sp_helpindex 'kindergarten'

FK_department_kindergarten  kindergarten.kid=department.kid 级联删除 级联更新


select a.name as 约束名,
object_name(b.parent_object_id) as 外键表,
d.name as 外键列,
object_name(b.referenced_object_id) as 主健表,
c.name as 主键列
from sys.foreign_keys A
inner join sys.foreign_key_columns B on A.object_id=b.constraint_object_id
inner join sys.columns C on B.parent_object_id=C.object_id and B.parent_column_id=C.column_id
inner join sys.columns D on B.referenced_object_id=d.object_id and B.referenced_column_id=D.column_id
where object_name(B.referenced_object_id)='kindergarten'  --表名


--Check约束
SELECT
  tab.name AS [表名],
  chk.name AS [Check约束名],
  col.name AS [列名],
  chk.definition
FROM
  sys.check_constraints chk
    JOIN sys.tables tab
      ON (chk.parent_object_id = tab.object_id)
    JOIN sys.columns col
      ON (chk.parent_object_id = col.object_id
          AND chk.parent_column_id = col.column_id)
          