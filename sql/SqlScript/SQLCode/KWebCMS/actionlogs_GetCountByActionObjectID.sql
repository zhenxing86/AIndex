USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetCountByActionObjectID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-09
-- Description:	根据 ActionObjectID 获取操作日志总数
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetCountByActionObjectID]
@actionobjectid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM actionlogs WHERE actionobjectid=@actionobjectid
	RETURN @count
END



GO
