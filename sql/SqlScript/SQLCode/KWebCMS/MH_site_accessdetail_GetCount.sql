USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_accessdetail_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取网站上月访问排行 网站总数
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_accessdetail_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(DISTINCT siteid) FROM site_accessdetail 
	WHERE DATEPART(yy,accessdatetime)=DATEPART(yy,GETDATE()) AND DATEPART(MM,accessdatetime)=DATEPART(MM,DATEADD(MM,-1,GETDATE())) 
	RETURN @count
END


GO
