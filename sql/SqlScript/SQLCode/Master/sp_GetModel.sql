USE master
GO
/*
	-- Author:      Master谭
	-- Create date: 2014-02-11
	-- Description: 过程用于统一取Model数据
	-- Paradef: 
	-- Memo:
*/ 
CREATE PROC sp_GetModel	
	@ID	bigint = null,
	@TbName varchar(50),
	@No	varchar(50) = null
AS
BEGIN
	SET NOCOUNT ON
	IF DB_NAME() = 'BasicData'
	BEGIN
		IF @TbName = 'FriendSMS'
		SELECT	ID, Userid, Touserid, msgtype, msgcon, CrtDate, IsRead
			FROM BasicData..FriendSMS
			WHERE ID = @ID
	END
	IF DB_NAME() = 'PayApp'
	BEGIN
		IF @TbName = 'order_record'
		SELECT	orderid,userid,plus_amount,plus_bean,actiondatetime,orderno,status,[from],PayType
			FROM PayApp..order_record
			WHERE orderno = @No
	END
	
END
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_GetModel';  
GO