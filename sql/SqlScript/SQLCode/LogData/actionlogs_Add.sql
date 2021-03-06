USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Add]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-09
-- Description:	添加操作日志 actionmodul普通为categoryid,会员登录为-1,发表和回复评论为-2,会员修改自己资料为-3,其它为0
-- =============================================
create PROCEDURE [dbo].[actionlogs_Add]
@userid int,
@usertype int,--1 为管理, 0 为会员
@actionmodul int,
@actionobjectid int,
@actiondesc nvarchar(200)
AS
BEGIN
	INSERT INTO actionlogs(userid,usertype,actionmodul,actionobjectid,actiondesc,actiondatetime) 
	VALUES(@userid,@usertype,@actionmodul,@actionobjectid,@actiondesc,GETDATE())

	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END





















GO
