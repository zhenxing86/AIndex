USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_CheckAccountExists]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[user_CheckAccountExists]
@userid int,
@account nvarchar(50)
 AS 
	DECLARE @status int
	SET @status=1
	IF(@userid>0)
	begin
		DECLARE @oldaccount nvarchar(50)
		SELECT @oldaccount=account FROM [user] WHERE userid=@userid
		IF(@oldaccount<>@account)
		BEGIN
			IF EXISTS(select 1 from [user] where account=@account and deletetag=1)
			BEGIN
				set @status=-2
			END
		END
	end
	else
	begin
		IF EXISTS(select 1 from [user] where account=@account and deletetag=1)
		BEGIN
			set @status=-2
		END

    --8位以内的纯数字帐号留给时光树使用, 网页端不允许使用
    if commonfun.dbo.fn_RegExMatch(@account, N'^\d{1,8}$') = 1
      set @status=-2
	end


RETURN @status


GO
