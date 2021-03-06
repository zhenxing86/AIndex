USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[varify_GetUser]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xzx
-- Modifier:	Master谭
-- Project: com.zgyey.verify
-- Create date: 2013-06-05
-- Description:	获取用户信息
-- =============================================
CREATE PROCEDURE [dbo].[varify_GetUser]
	@account nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON
	select account,name,mobile,userid 
		from BasicData..[user]
	  where account = @account 
	  and deletetag = 1
END

GO
