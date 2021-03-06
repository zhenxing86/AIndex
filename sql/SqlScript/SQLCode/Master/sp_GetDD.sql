USE [master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--当前数据库的数据表数据字典  
谭磊 2013-03-10 创建      
*/  
CREATE Procedure [dbo].[sp_GetDD]      
	@object_name varchar(125)        
AS        
        
Set NoCount On      
      
SELECT --d.name  N'表名',      
       a.colorder N'序号',      
       a.name N'字段名',      
       isnull(g.[value], '') AS N'说明',      
       b.name N'类型',      
       --a.length N'占用字节数',      
       ColumnProperty(a.id, a.name, 'PRECISION') as N'长度',      
       isnull(ColumnProperty(a.id, a.name, 'Scale'), 0) as N'小数',      
       (case when ColumnProperty(a.id, a.name, 'IsIdentity') = 1 then '√' else '' end) N'标识',      
       (case when (SELECT count(*) FROM sysobjects      
                   WHERE (name in (SELECT name FROM sysindexes       
                                   WHERE (id = a.id)      
                                   AND (indid in (SELECT indid      
                                                  FROM sysindexkeys      
                                                  WHERE (id = a.id)      
                                                  AND (colid in (SELECT colid      
                                                                 FROM syscolumns      
                                                                 WHERE (id = a.id) AND (name = a.name)      
                                                                )      
                                                      )      
                                                 )      
                                       )      
                                  )      
                         )      
                   AND (xtype = 'PK')      
                  ) > 0 then '√' else '' end      
       ) N'主键',      
       (case when a.isnullable = 1 then '√' else '' end) N'允许空',      
       isnull(e.text, '') N'默认值',      
       '' 其他说明,      
       case when isnull(a.iscomputed,0)=0 then '' else '√' end N'计算列',      
       case when isnull(f.text,'')='' then '' else f.text end N'计算公式'      
--into ##tx      
FROM syscolumns a left join systypes b on a.xtype = b.xusertype      
                  inner join sysobjects d on a.id = d.id and d.xtype = 'U' and d.name <> 'dtproperties'      
                  left join syscomments e on a.cdefault = e.id      
                  left join syscomments f on a.id = f.id and f.number=a.colid      
                  left join sys.extended_properties  g on a.id = g.major_id AND a.colid = g.minor_id      
where a.id=object_id(@object_name)      
-- and a.name='字段名'       
order by object_name(a.id), a.colorder      
      
--索引与键      
--Select a.name+'('+c.name+')' N'索引'      
--from sys.indexes a left join sys.index_columns b on a.object_id=b.object_id and a.Index_Id=b.Index_id      
--                   left join syscolumns c on b.object_id=c.id and b.column_id=c.colid      
--where a.object_id=object_ID(@object_name) and isnull(c.name,'')<>''      
Select a.name IndexName,c.name IndexField,      
  case when isnull(b.is_descending_key,0)=0 then 'Asc' else 'Desc' end AscDesc,      
  cast(null as varchar(500)) IndexField1          
into #Index      
from sys.indexes a left join sys.index_columns b on a.object_id=b.object_id and a.Index_Id=b.Index_id      
                   left join syscolumns c on a.object_id=c.id and b.column_id=c.colid      
where a.object_id=object_ID(@object_name) and isnull(c.name,'')<>''      
      
select IndexName into #IndexName from #Index group by IndexName      
      
declare @str varchar(500),@IndexName varchar(128)      
while exists(Select * from #IndexName)      
begin       
  set @str=''      
  Select @IndexName=IndexName from #IndexName      
  select @str=@str+IndexField+' '+ AscDesc+',' from #Index where IndexName=@IndexName      
  Select @str=left(@str,len(@str)-1)      
  update #Index set IndexField1=@str where IndexName=@IndexName      
  delete #IndexName where IndexName=@IndexName      
end      
Select IndexName+'('+IndexField1+')' N'索引' from #Index group by IndexName,IndexField1      
drop table #Index,#IndexName      
      
--触发器    
Select name N'触发器'      
from sys.triggers       
where parent_id=object_ID(@object_name)       
      
--关系      
Select a.name +'  ' + object_name(c.id)+'.'+c.name+'='+object_name(d.id)+'.'+d.name-- N'关系字段',      
  +' '+case when isnull(delete_referential_action,0)=1 then '级联删除' else '' end-- N'级联删除',      
  +' '+case when isnull(update_referential_action,0)=1 then '级联更新' else '' end-- N'级联更新'      
  N'关系'      
from sys.foreign_keys a      
       left join sys.foreign_key_columns b on a.object_Id=b.constraint_object_Id      
       left join syscolumns c on b.referenced_object_id=c.id and b.referenced_Column_id=c.colid      
       left join syscolumns d on b.parent_object_Id=d.id and b.parent_Column_id=d.colid      
where a.referenced_object_id=object_ID(@object_name)      
      
--约束      
Select name+'(检查)  ' + definition N'约束'      
from sys.check_constraints       
where parent_object_id=object_ID(@object_name)
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_GetDD'; 
GO