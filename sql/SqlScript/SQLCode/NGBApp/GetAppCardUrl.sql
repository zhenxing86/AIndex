USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetAppCardUrl]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	
exec GetAppCardUrl 295765	
*/
CREATE PROC [dbo].[GetAppCardUrl]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @gtype int
	SELECT @gtype = isnull(g.gtype, CASE CommonFun.dbo.fn_age(uc.birthday) WHEN 2 THEN 4 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END) 
		FROM BasicData..[User_Child] uc 
			LEFT join BasicData..grade g 
			on uc.grade = g.gid  
		where uc.userid = @userid 

	SELECT url FROM AppCard where gtype = @gtype and ShowMonth = MONTH(GETDATE())
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取卡片地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetAppCardUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetAppCardUrl', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
