USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_templet_getCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl
-- Create date: 2014-05-15
-- Description:	获取报名控件模版表的总数
-- =============================================
CREATE PROCEDURE [dbo].[cms_templet_getCount]
	@siteid int
AS
BEGIN
	DECLARE @count int
	if(@siteid>=0)
	begin
	SELECT @count=count(*) FROM enlistonline_templet c,site s where c.siteid=s.siteid and c.siteid=@siteid and deletetag=1
	end
	else
	begin
	SELECT @count=count(*) FROM enlistonline_templet c,site s where c.siteid=s.siteid and deletetag=1
	end
	print @count
	RETURN @count
END

GO
