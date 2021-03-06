USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	获取内容实体
-- Memo:		
*/
CREATE PROCEDURE [dbo].[cms_content_GetModel]
	@contentid int
AS
BEGIN
	SELECT	contentid,categoryid,content,title,titlecolor,author,
					createdatetime,searchkey,searchdescription,browsertitle,
					commentcount,orderno,commentstatus,ispageing,status, draftstatus
	FROM cms_content 
	WHERE contentid = @contentid and deletetag = 1
END

GO
