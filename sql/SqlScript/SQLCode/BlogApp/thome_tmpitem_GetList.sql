USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_tmpitem_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询模板列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-20 9:53:48
------------------------------------
CREATE PROCEDURE [dbo].[thome_tmpitem_GetList]
@kid int
 AS 
	DECLARE @KItemCount int	
	SELECT @KItemCount = count(1) FROM thome_tmpitem 
	WHERE kid=@KID
	
	IF(@KItemCount=0)
	BEGIN
		INSERT INTO thome_tmpitem(kid, title,status) 
		SELECT @kid,title,1 FROM thome_tmpitem WHERE (kid=0) and status=1
	END

	SELECT 
		tmpitemid,kid,title,status
	 FROM thome_tmpitem
	 WHERE kid=@kid 






GO
