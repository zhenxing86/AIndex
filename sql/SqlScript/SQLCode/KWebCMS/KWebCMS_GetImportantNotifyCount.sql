USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_GetImportantNotifyCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-02
-- Description:	重要通知读取
-- =============================================
CREATE PROCEDURE [dbo].[KWebCMS_GetImportantNotifyCount]
AS
BEGIN
	DECLARE @count int	
	SELECT @count=count(id) FROM zgyey_om..t_titleurl 
	WHERE type=3 and tag=0
	RETURN @count
END

























GO
