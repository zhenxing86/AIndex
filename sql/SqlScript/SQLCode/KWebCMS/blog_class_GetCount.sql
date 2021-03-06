USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_class_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_class_GetCount]
@kid int
AS 
BEGIN
	DECLARE @count int
	SELECT @count=count(t1.cid) FROM basicdata..class t1
	WHERE (deletetag=1 or deletetag=-2) AND kid=@kid
	RETURN @count
END

GO
