USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改一条公司分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_Update]
@companycategoryid int,
@title nvarchar(50),
@description nvarchar(200)
 AS 
	UPDATE [companycategory] SET 
	[title] = @title,[description] = @description,[source] = 1,[createdate] = getdate()
	WHERE companycategoryid=@companycategoryid 

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END


GO
