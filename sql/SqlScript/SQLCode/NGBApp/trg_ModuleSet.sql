USE [NGBApp]
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
ALTER TRIGGER trg_ModuleSet ON [dbo].[ModuleSet]                            
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
	--插入修改日志 	

		if UPDATE([hbModList])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'ModuleSet', i.[kid], i.[term], 1, 'hbModList', d.[hbModList], i.[hbModList], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[kid] = d.[kid]
					 and  i.[term] = d.[term]
					 and  ISNULL(i.[hbModList],0) <> ISNULL(d.[hbModList],0)
		END

		if UPDATE([celltype])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'ModuleSet', i.[kid], i.[term], 1, 'celltype', d.[celltype], i.[celltype], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[kid] = d.[kid]
					 and  i.[term] = d.[term]
					 and  ISNULL(i.[celltype],0) <> ISNULL(d.[celltype],0)
		END
	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'ModuleSet', [kid], [term], 0, @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'ModuleSet', [kid], [term], 2, @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(DbName,TbName, DoWhere, DoUserID, Col1, Col2, Col3, Col4, Col5, Col6)
		SELECT Db_Name(), 'ModuleSet', @DoProc, @DoUserID, [kid], [term], [hbModList], [gbModList], [Monadvset], [celltype]
			from deleted 
	END
END
GO

