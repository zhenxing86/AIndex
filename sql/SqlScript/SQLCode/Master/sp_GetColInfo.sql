use master
go
/*      
--当前数据库的数据表数据字典  
谭磊 2013-03-10 创建    
use commonfun
go
 exec [sp_GetColInfo] 'fn_DayList'
*/  
ALTER Procedure [dbo].[sp_GetColInfo]      
	 @objname nvarchar(776) = NULL  -- object name we're after  
AS        
BEGIN        
Set NoCount On    
declare @no varchar(35), @yes varchar(35)
SELECT @no = '', @yes = '√'
select	c.column_id, c.name, 
				type_name(c.user_type_id)+ CASE 
					WHEN type_name(c.user_type_id) IN('char','varchar','varbinary','binary') 
						THEN '('+case when c.max_length = -1 then 'max' ELSE CAST(c.max_length as varchar(10)) END +')' 
					WHEN type_name(c.user_type_id) IN('nchar','nvarchar') 
						THEN '('+case when c.max_length = -1 then 'max' ELSE CAST(c.max_length/2 as varchar(10)) END +')' 			
					ELSE '' END xtype,
				isnull(e.[value], '') AS N'Descript', 
				case when c.is_identity = 1 then @yes else @no end N'is_identity',
				case when ic.column_id is null then @no else @yes end N'is_primary_key',
				case when c.is_nullable = 1 then @yes else @no end N'is_nullable',
				ISNULL(d.definition,'') N'Default_value',
				ISNULL(cc.definition,'') N'ComputeStr',				
				case when e1.[value] is null then @no else @yes end AS N'Is_Abolish' 
	from sys.columns c
		left join sys.extended_properties  e 
			on c.object_id = e.major_id and e.class = 1 AND c.column_id = e.minor_id AND e.name = 'MS_Description' 
		left join sys.extended_properties  e1 
			on c.object_id = e.major_id and e1.class = 1 AND c.column_id = e1.minor_id AND e1.name = 'Abolish' 
		left join sys.default_constraints d on d.parent_object_id = c.object_id and d.parent_column_id = c.column_id
		left join sys.computed_columns  cc on cc.object_id = c.object_id and cc.column_id = c.column_id
		left join sys.indexes i on i.object_id = c.object_id and i.is_primary_key = 1 		
		left join sys.index_columns ic on i.index_id = ic.index_id and ic.object_id = i.object_id And ic.column_id = c.column_id
	where c.object_id = object_id(@objname) 
	
select	p.parameter_id, p.name, 
				type_name(p.user_type_id)+ CASE 
					WHEN type_name(p.user_type_id) IN('char','varchar','varbinary','binary') 
						THEN '('+case when p.max_length = -1 then 'max' ELSE CAST(p.max_length as varchar(10)) END +')' 
					WHEN type_name(p.user_type_id) IN('nchar','nvarchar') 
						THEN '('+case when p.max_length = -1 then 'max' ELSE CAST(p.max_length/2 as varchar(10)) END +')' 			
					ELSE '' END xtype,
				isnull(e.[value], '') AS N'Descript', 
				N'Default_value' = '',--ISNULL(d.definition,'') ,
				case when e1.[value] is null then @no else @yes end AS N'Is_Abolish' 
	from sys.parameters p
		left join sys.extended_properties  e 
			on p.object_id = e.major_id and e.class = 2 AND p.parameter_id = e.minor_id AND e.name = 'MS_Description' 
		left join sys.extended_properties  e1 
			on p.object_id = e.major_id and e1.class = 2 AND p.parameter_id = e1.minor_id AND e1.name = 'Abolish' 
	where p.object_id = object_id(@objname)
		and p.parameter_id<>0 

END
GO
EXEC sp_MS_marksystemobject 'dbo.sp_GetColInfo'; 
go