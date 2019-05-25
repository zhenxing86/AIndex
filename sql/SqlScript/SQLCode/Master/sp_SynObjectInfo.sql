use master
go
/*      
--同步单个对象  
谭磊 2014-01-16 创建   
*/  
ALTER Procedure [dbo].[sp_SynObjectInfo]
	@objtype sysname,
	@objname sysname,
	@userName varchar(50) 
AS        
BEGIN        
	Set NoCount On  
	DECLARE @Is_FullFill int = 1,@M_Descript sql_variant
	BEGIN
		IF EXISTS(
		select *
			from sys.objects o
				inner join sys.columns c on o.object_id = c.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 1 AND c.column_id = e.minor_id AND e.name = 'MS_Description' 
			WHERE c.name not in('kid','cid','userid','deletetag')
				and c.is_identity = 0
				and e.value is null
				and o.name = @objname			
		)
		SET @Is_FullFill = 0
		
		IF EXISTS(
		select *
			from sys.objects o
				inner join sys.parameters p on o.object_id = p.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 2 AND p.parameter_id = e.minor_id AND e.name = 'MS_Description' 
			WHERE p.name not in('@kid','@cid','@userid')
				and p.object_id = object_id(@objname)
				and p.parameter_id<>0 
				and e.value is null
				and o.name = @objname			
		)
		SET @Is_FullFill = 0
		
		IF NOT EXISTS(
		SELECT * 
			FROM sys.objects o
				INNER join sys.extended_properties e
					on o.object_id = e.major_id 
					and e.class = 1
					and e.minor_id = 0 
					and e.name = 'MS_Description'
			WHERE o.name = @objname
		)
	SET @Is_FullFill = 0		
	END			

	UPDATE Commonfun..Object_List 
		SET	userName = @userName,
				ModifyTime = GETDATE(),
				Is_Abolish = CASE WHEN EXISTS(
	select *
		from sys.objects o
			INNER join sys.extended_properties e1
						on o.object_id = e1.major_id 
						and e1.class = 1
						and e1.minor_id = 0 
						and e1.name = 'Abolish'
						and o.name = @objname 
	) then 1 else 0 end
		WHERE DBName = DB_NAME()
			AND Name = @objname	
	
	--SELECT *,@Is_MainDes Is_MainDes, @Is_SubDes Is_SubDes FROM  Commonfun..Object_List WHERE DBName = DB_NAME()	AND Name = @objname		
	UPDATE Commonfun..Object_List 
		SET Is_FullFill = @Is_FullFill
		WHERE DBName = DB_NAME()
			AND Name = @objname	
	
	UPDATE ol
		SET Descript = e.value
		FROM Commonfun..Object_List ol
			LEFT JOIN sys.extended_properties e
				on e.major_id = ol.Object_id
				and e.class = 1
				and e.minor_id = 0 
				and e.name = 'MS_Description'		
		WHERE ol.DBName = DB_NAME()
			AND ol.Name = @objname
					
	UPDATE ol
		SET UpdateTime = o.modify_date
		FROM Commonfun..Object_List ol
			inner JOIN sys.objects o
				on o.Object_id = ol.Object_id
		WHERE ol.DBName = DB_NAME()
			AND ol.Name = @objname	
			AND ol.UpdateTime <> o.modify_date

END
GO
EXEC sp_MS_marksystemobject 'dbo.sp_SynObjectInfo'; 