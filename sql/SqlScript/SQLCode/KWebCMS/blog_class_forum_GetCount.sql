USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_class_forum_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	lx
-- ALTER date: 2009-02-03
-- Description:	获取特定categoryid的记录数
-- =============================================
CREATE PROCEDURE [dbo].[blog_class_forum_GetCount]
@kid int,@parentid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM classapp..v_newforumpost WHERE kid=@kid 
	RETURN @count
END


GO
