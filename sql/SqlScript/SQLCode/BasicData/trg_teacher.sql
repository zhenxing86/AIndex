USE [BasicData]
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
ALTER TRIGGER trg_teacher ON [dbo].[teacher]                            
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

		if UPDATE([did])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT 'teacher',i.[userid], 1, 'did', d.[did], i.[did], @DoProc, @DoUserID
				from inserted i inner join deleted d on i.[userid] = d.[userid]
					AND ISNULL(i.[did],0) <> ISNULL(d.[did],0)
		END

		if UPDATE([title])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT 'teacher',i.[userid], 1, 'title', d.[title], i.[title], @DoProc, @DoUserID
				from inserted i inner join deleted d on i.[userid] = d.[userid]
					AND ISNULL(i.[title],0) <> ISNULL(d.[title],0)
		END

		if UPDATE([post])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT 'teacher',i.[userid], 1, 'post', d.[post], i.[post], @DoProc, @DoUserID
				from inserted i inner join deleted d on i.[userid] = d.[userid]
					AND ISNULL(i.[post],0) <> ISNULL(d.[post],0)
		END
	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(TbName,KeyCol, DoType, ColName, NewValue, DoWhere, DoUserID)
		SELECT 'teacher', [userid], 0, 'userid', [userid], @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(TbName,KeyCol, DoType, ColName, NewValue, DoWhere, DoUserID)
		SELECT 'teacher', [userid], 2, 'userid', [userid], @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(TbName, DoWhere, DoUserID,Col1,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9)
		SELECT 'teacher', @DoProc, @DoUserID, *
			from deleted 
	END
END
GO

