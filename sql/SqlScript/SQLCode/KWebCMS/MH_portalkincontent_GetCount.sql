USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalkincontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	得到招聘或园长评价文章总数
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalkincontent_GetCount]
@contenttype int  --0为招聘,1为园长评价
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM portalkincontent WHERE contenttype=@contenttype and deletetag = 1
	RETURN @count
END

GO
