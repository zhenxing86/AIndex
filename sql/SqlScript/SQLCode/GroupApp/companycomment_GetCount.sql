USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycomment_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家评论数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 14:48:59
------------------------------------
CREATE PROCEDURE [dbo].[companycomment_GetCount]
@companyid int
 AS 

	DECLARE @count INT
	SELECT @count=count(1) FROM companycomment WHERE companyid=@companyid and status=1 and parentid=0 
	RETURN @count

GO
