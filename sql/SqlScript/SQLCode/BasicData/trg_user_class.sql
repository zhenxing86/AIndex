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
CREATE TRIGGER trg_user_class ON [dbo].[user_class]                            
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

		if UPDATE([cid])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'user_class', i.[ucid], 1, 'cid', d.[cid], i.[cid], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[ucid] = d.[ucid]
					 and  ISNULL(i.[cid],0) <> ISNULL(d.[cid],0)
		END

		if UPDATE([userid])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'user_class', i.[ucid], 1, 'userid', d.[userid], i.[userid], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[ucid] = d.[ucid]
					 and  ISNULL(i.[userid],0) <> ISNULL(d.[userid],0)
		END
	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		UPDATE u SET updatetime = GETDATE()  
			FROM BasicData.dbo.[user] u 
				inner join inserted i   
					on u.userid = i.userid   
		INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)
		SELECT Db_Name(),'user_class', [ucid], 0, @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'user_class', [ucid], 2, @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(DbName, TbName, DoWhere, DoUserID, Col1, Col2, Col3)
		SELECT Db_Name(), 'user_class', @DoProc, @DoUserID, [cid], [userid], [ucid]
			from deleted 
	END
END
GO