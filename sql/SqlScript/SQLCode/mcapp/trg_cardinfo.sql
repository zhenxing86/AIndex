USE [mcapp]
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
ALTER TRIGGER trg_cardinfo ON [dbo].[cardinfo]                            
  for INSERT, UPDATE, DELETE                       
AS
BEGIN           
	if @@RowCount <= 0 Return                
	set nocount on  
	
	declare @DelCnt int, @InsCnt int
	DECLARE @DoUserID int, @DoProc varchar(50), @DoWhere varchar(50)  --读取上下文信息
	EXEC commonfun.dbo.GetDoInfo @DoUserID OUTPUT, @DoProc OUTPUT
	SELECT @DoWhere = right(@DoProc,len(@DoProc) - CHARINDEX('&',@DoProc)) 
	SELECT @DoProc = LEFT(@DoProc,len(@DoProc) - CHARINDEX('&',reverse(@DoProc)))
	if ISNUMERIC(@DoWhere) = 0
	set @DoWhere = '0'
	
	SELECT @DelCnt = COUNT(1) FROM deleted
	SELECT @InsCnt = COUNT(1) FROM inserted
	
	IF NOT UPDATE(udate)
			UPDATE cardinfo 
				SET udate = GETDATE()
				FROM cardinfo c inner join inserted i 
					on c.card = i.card 
	IF NOT UPDATE(DoUserid)
			UPDATE cardinfo 
				SET DoUserid = @DoUserID
				FROM cardinfo c inner join inserted i 
					on c.card = i.card 
	IF NOT UPDATE(dowhere)
			UPDATE cardinfo 
				SET dowhere = @DoWhere
				FROM cardinfo c inner join inserted i 
					on c.card = i.card 
					
	IF UPDATE(userid)
	BEGIN
		UPDATE u SET updatetime = GETDATE()
			FROM BasicData..[user] u 
				inner join inserted i 
					on u.userid = i.userid 
				LEFT join deleted d 
					on i.card = d.card 
			where ISNULL(i.userid,0) <> ISNULL(d.userid,0)				

		UPDATE u SET updatetime = GETDATE()
			FROM BasicData..[user] u 
				inner join deleted d 
					on u.userid = d.userid
				LEFT join inserted i 
					on i.card = d.card 
			where ISNULL(i.userid,0) <> ISNULL(d.userid ,0)
	END		
	
	IF @DelCnt > 0 and @InsCnt > 0
	BEGIN 
	--插入修改日志 						
		if UPDATE([kid])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'cardinfo', i.[card], 1, 'kid', d.[kid], i.[kid], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[card] = d.[card]
					 and  ISNULL(i.[kid],0) <> ISNULL(d.[kid],0)
		END

		if UPDATE([usest])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'cardinfo', i.[card], 1, 'usest', d.[usest], i.[usest], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[card] = d.[card]
					 and  ISNULL(i.[usest],0) <> ISNULL(d.[usest],0)
		END

		if UPDATE([userid])
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'cardinfo', i.[card], 1, 'userid', d.[userid], i.[userid], @DoProc, @DoUserID
				from inserted i 
					inner join deleted d 
						on  i.[card] = d.[card]
					 and  ISNULL(i.[userid],0) <> ISNULL(d.[userid],0)
		END
	END 
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'cardinfo', [card], 0, @DoProc, @DoUserID
			from inserted 
	END
	ELSE IF @DelCnt > 0 and @InsCnt = 0	
	--插入删除日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, DoWhere, DoUserID)
		SELECT Db_Name(), 'cardinfo', [card], 2, @DoProc, @DoUserID
			from deleted 
		INSERT INTO AppLogs.dbo.DelLog(DbName, TbName, DoWhere, DoUserID, Col1, Col2, Col3, Col4, Col5, Col6, Col8, Col9, Col10, Col11, Col12, Col13)
		SELECT Db_Name(), 'cardinfo', @DoProc, @DoUserID, [id], [kid], [card], [udate], [usest], [CardType], [userid], [EnrolNum], [cardno], [memo], [DoUserid], [DoWhere]
			from deleted 
	END
END
GO

