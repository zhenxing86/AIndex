USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portalztttcontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		along
-- Create date: 2009-12-24
-- Description:	获取门户分类内容总数
-- =============================================
create PROCEDURE [dbo].[mh_portalztttcontent_GetCount]
@status int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM mh_content_content_relation 
	WHERE status=@status
	RETURN @count
END






GO
