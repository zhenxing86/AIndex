USE [BasicData]
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Up_user]'))
DROP TRIGGER [dbo].Up_user
GO
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
ALTER TRIGGER [dbo].[Up_user] ON [dbo].[user]                           
  for INSERT, UPDATE                       
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
		if NOT UPDATE(updatetime) 
		BEGIN 			
			--IF NOT( SUBSTRING(COLUMNS_UPDATED(),1,1) = 64 and SUBSTRING(COLUMNS_UPDATED(),2,100) = 0 )
			if UPDATE(name) or UPDATE(birthday) or UPDATE(gender)or UPDATE(tts)
			BEGIN 				
				UPDATE u SET updatetime = GETDATE()
				FROM [user] u inner join inserted i 
					on u.userid = i.userid
			END
			if UPDATE(deletetag) 
			UPDATE u SET deletedatetime = GETDATE()
			FROM [user] u inner join inserted i 
				on u.userid = i.userid 
		END
		--插入修改日志 	
		if UPDATE(userid)
		BEGIN
		  raiserror('不允许更新userid',11,1)
			ROLLBACK
		END

		if UPDATE(account)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'account', d.account, i.account, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.account,0) <> ISNULL(d.account,0)
		END

		if UPDATE(password)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'password', d.password, i.password, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.password,0) <> ISNULL(d.password,0)
		END

		if UPDATE(usertype)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'usertype', d.usertype, i.usertype, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.usertype,0) <> ISNULL(d.usertype,0)
		END

		if UPDATE(deletetag)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'deletetag', d.deletetag, i.deletetag, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.deletetag,0) <> ISNULL(d.deletetag,0)
		END

		if UPDATE(kid)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'kid', d.kid, i.kid, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.kid,0) <> ISNULL(d.kid,0)
			
			Update a set siteid = b.kid
        From kwebcms.dbo.site_user a, inserted b
        Where a.appuserid = b.userid and a.siteid <> b.kid
		END

		if UPDATE(name)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'name', d.name, i.name, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.name,0) <> ISNULL(d.name,0)
			
			UPdate a Set uname = b.name
			  From HealthApp.dbo.BaseInfo a, Inserted b
			  Where a.kid = b.kid and a.uid = b.userid and a.uname <> b.name
		END

		if UPDATE(birthday)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'birthday', d.birthday, i.birthday, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.birthday,0) <> ISNULL(d.birthday,0)
	
			UPdate a Set birthday = b.birthday
			  From HealthApp.dbo.BaseInfo a, Inserted b
			  Where a.kid = b.kid and a.uid = b.userid and a.birthday <> b.birthday
		END

		if UPDATE(mobile)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'mobile', d.mobile, i.mobile, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.mobile,0) <> ISNULL(d.mobile,0)
		END		

		if UPDATE(headpic)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'headpic', d.headpic, i.headpic, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.headpic,0) <> ISNULL(d.headpic,0)
		END
		
		if UPDATE(smsport)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'smsport', d.smsport, i.smsport, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.smsport,0) <> ISNULL(d.smsport,0)
		END
		
		if UPDATE(NGB_gbVersionTag)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'NGB_gbVersionTag', d.NGB_gbVersionTag, i.NGB_gbVersionTag, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.NGB_gbVersionTag,0) <> ISNULL(d.NGB_gbVersionTag,0)
		END		

		if UPDATE(gbstatus)
		BEGIN
			INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(),'user',i.userid, 1, 'gbstatus', d.gbstatus, i.gbstatus, @DoProc, @DoUserID
				from inserted i inner join deleted d on i.userid = d.userid
					AND ISNULL(i.gbstatus,0) <> ISNULL(d.gbstatus,0)
		END		
		END	
	ELSE IF @DelCnt = 0 and @InsCnt > 0	
	--插入新增日志   
	BEGIN
		INSERT INTO AppLogs.dbo.EditLog(DbName,TbName,KeyCol, DoType, ColName, NewValue, DoWhere, DoUserID)
		SELECT Db_Name(),'user',userid, 0, 'userid', userid, @DoProc, @DoUserID
			from inserted 

	END
END



GO


