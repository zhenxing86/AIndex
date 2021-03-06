USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_class_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[kweb_blog_class_GetCount]
@kid int,
@caption nvarchar(30)
AS 
BEGIN
	DECLARE @count int
	SELECT @count=count(t1.cid) FROM basicdata..class t1 
	JOIN basicdata..grade t3 ON t1.grade=t3.gid
	JOIN blog_classlist t2 ON t1.cid=t2.classid
	WHERE (t1.deletetag=1 or t1.deletetag=-2) AND t1.kid=@kid
	AND t3.gid=convert(int,@caption)
	RETURN @count
END

GO
