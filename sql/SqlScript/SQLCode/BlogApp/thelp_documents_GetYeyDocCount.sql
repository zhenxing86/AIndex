USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetYeyDocCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询幼儿园文档列表数量
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-03 15:12:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetYeyDocCount]
@kid int
 AS
	
	DECLARE @TempID int	

    SELECT @TempID = count(1) FROM thelp_documents t1 LEFT JOIN thelp_categories t2
		ON t1.categoryid = t2.categoryid inner JOIN bloguserkmpUser t3
		ON t2.userid = t3.bloguserid WHERE  t1.deletetag=1 and t1.kindisplay=1 and t3.kid=@kid		
	RETURN @TempID




GO
