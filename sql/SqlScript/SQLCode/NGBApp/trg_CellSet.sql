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
ALTER TRIGGER trg_CellSet ON [dbo].[CellSet]                            
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
		if UPDATE([cellset])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'CellSet', i.[kid], i.[celltype], 1, 'cellset', d.[cellset], i.[cellset], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[kid] = d.[kid]
					 and  i.[celltype] = d.[celltype]
					 and  ISNULL(i.[cellset],0) <> ISNULL(d.[cellset],0)
		END
	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'CellSet', [kid], [celltype], 0, @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], [keycol2], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'CellSet', [kid], [celltype], 2, @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(DbName,TbName, DoWhere, DoUserID, Col1, Col2, Col3)
		SELECT Db_Name(), 'CellSet', @DoProc, @DoUserID, [kid], [celltype], [cellset]
			from deleted 
	END
END
GO

