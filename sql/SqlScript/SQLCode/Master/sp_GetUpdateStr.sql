USE master
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
ALTER PROC sp_GetUpdateStr 
	@TbName varchar(50),
	@TbNameCh varchar(50) = '',
	@keyCol varchar(150),	
	@colstr varchar(500),
	@colstrCh varchar(1000) = '',
	@kidinfo varchar(1000) = ''
as
BEGIN
	SET NOCOUNT ON
	DECLARE @DelColStr varchar(2000),@keycollist varchar(150),
					@inskeycolvalue varchar(150),@joinkeycolvalue varchar(150),
					@keycolvalue varchar(150),@keycolname varchar(150),@DelColValue varchar(500)
	select	@DelColStr = CommonFun.dbo.sp_GetSumStr(', Col'+CAST(column_id AS VARCHAR(10))), 
					@DelColValue = CommonFun.dbo.sp_GetSumStr(', ['+name+']')
		from sys.columns 
								where object_id= object_id(@TbName) 				 			 
	select	@keycollist = CommonFun.dbo.sp_GetSumStr('[keycol'+isnull(CAST(NULLIF(pos,1) AS VARCHAR(10)),'')+'], '),
					@inskeycolvalue = CommonFun.dbo.sp_GetSumStr('i.['+col +'], '),
					@keycolvalue = CommonFun.dbo.sp_GetSumStr('['+col +'], '),
					@keycolname = CommonFun.dbo.sp_GetSumStr(''''+col +''', '),
					@joinkeycolvalue = CommonFun.dbo.sp_GetSumStr(' i.['+col+'] = d.['+col+']
					 and ')	 	
		from CommonFun.dbo.f_split(@keyCol,',') 
		
select 
'
USE ['+db_name()+']
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE TRIGGER trg_'+@TbName+' ON [dbo].['+@TbName+']                            
  for INSERT, UPDATE, DELETE                       
AS
BEGIN           
	if @@RowCount <= 0 Return                
	set nocount on
	declare @DelCnt int, @InsCnt int
	DECLARE @DoUserID int, @DoProc varchar(50)  --读取上下文信息
	EXEC commonfun.dbo.GetDoInfo @DoUserID OUTPUT, @DoProc OUTPUT
	
	SELECT @DelCnt = COUNT(1) FROM deleted
	SELECT @InsCnt = COUNT(1) FROM inserted
	IF @DelCnt > 0 and @InsCnt > 0
	BEGIN 
	--插入修改日志 	'
UNION ALL
select 
CASE WHEN is_identity = 1
THEN 
'
		if UPDATE(['+name+'])
		BEGIN
		  raiserror(''不允许更新'+name+''',11,1)
			ROLLBACK
		END
'
ELSE
'
		if UPDATE(['+name+'])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, '+@keycollist+'DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), '''+@TbName+''', '+@inskeycolvalue+'1, '''+name+''', d.['+name+'], i.['+name+'], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on '+@joinkeycolvalue+' ISNULL(i.['+name+'],0) <> ISNULL(d.['+name+'],0)
		END
'
END
 from sys.columns where object_id= object_id(@TbName) AND ','+@colstr+',' like '%,'+name+',%'
UNION ALL
select 
'	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, '+@keycollist+'DoType, DoWhere, DoUserID)
		SELECT Db_Name(),'''+@TbName+''', '+@keycolvalue+'0, @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, '+@keycollist+'DoType, DoWhere, DoUserID)
		SELECT Db_Name(), '''+@TbName+''', '+@keycolvalue+'2, @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(DbName, TbName, DoWhere, DoUserID'+@DelColStr+')
		SELECT Db_Name(), '''+@TbName+''', @DoProc, @DoUserID'+@DelColValue+'
			from deleted 
	END
END
GO
'
IF ISNULL(@TbNameCh,'')<>''
BEGIN
SELECT 'insert into AppLogs..TbList(DbName,TbName, '+@keycollist+'Descript,KidInfo)
select Db_Name(), '''+@TbName+''', '+@keycolname+''''+@TbNameCh+''', '''+ISNULL(@kidinfo,'')+''''
SELECT 'insert into AppLogs..TbCol(TbID, ColName, Descript, IsFilter,ColType)
	select TbID, '''+a.col+''', '''+b.col+''',1,'''+
    type_name(c.user_type_id)+ CASE   
     WHEN type_name(c.user_type_id) IN('char','varchar','varbinary','binary')   
      THEN '('+case when c.max_length = -1 then 'max' ELSE CAST(c.max_length as varchar(10)) END +')'   
     WHEN type_name(c.user_type_id) IN('nchar','nvarchar')   
      THEN '('+case when c.max_length = -1 then 'max' ELSE CAST(c.max_length/2 as varchar(10)) END +')'      
     ELSE '' END
+'''
	FROM AppLogs..TbList WHERE DbName = Db_Name()	AND TbName = '''+@TbName+'''
'		
	from CommonFun.dbo.f_split(@colstr,',') a 
		INNER JOIN CommonFun.dbo.f_split(@colstrCh,',') b
			on a.pos = b.pos
		INNER JOIN sys.columns c ON c.object_id= object_id(@TbName) AND c.name = a.col
		
END


END
GO
USE master;EXEC sp_MS_marksystemobject 'dbo.sp_GetUpdateStr';  
