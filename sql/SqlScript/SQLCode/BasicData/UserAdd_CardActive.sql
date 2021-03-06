USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UserAdd_CardActive]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-14
-- Description:	函数用于判断激活码是否有效
-- Memo:	
DECLARE @R INT
EXEC	@R = UserAdd_CardActive '123','123',0,'123','1'
SELECT @R
*/
CREATE PROC [dbo].[UserAdd_CardActive]
	@account nvarchar(50),
	@mobile nvarchar(50),
	@NJType int,
	@password nvarchar(50),
	@activecode VARCHAR(10),
	@IP varchar(50)	
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @userid int
	Begin tran 	 
	BEGIN TRY  
		IF NOT EXISTS(SELECT * FROM ActivationCode WHERE CodeNo = @activecode AND userid IS NULL)
		raiserror('激活码异常',11,1)
		INSERT INTO BasicData..[user]
							(account, password, mobile, regdatetime, RoleType, NJType, deletetag)
			select	@account, @password, @mobile, GETDATE(), 2, @NJType, 1
		select @userid = ident_current('user') 
		update ActivationCode 
			SET userid = @userid,
					IP = @IP,
					ActDate = GETDATE() 
			WHERE CodeNo = @activecode
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1
END

GO
