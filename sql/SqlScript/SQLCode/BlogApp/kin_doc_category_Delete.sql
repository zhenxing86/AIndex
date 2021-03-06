USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除幼儿园共享分类 
--项目名称：BLOG
--说明：
--时间：2009-6-27 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[kin_doc_category_Delete]
@kincategoryid int,
@userid int
 AS 
	DECLARE @kmpuserid int
	DECLARE @kid int
	SELECT @kmpuserid=kmpuserid FROM bloguserkmpuser WHERE bloguserid=@userid
	SELECT @kid=kid FROM kin_doc_category WHERE kincategoryid=@kincategoryid

	IF(dbo.IsManager(@kmpuserid,@kid)=1)
	BEGIN
		DELETE [kin_doc_category] WHERE parentid=@kincategoryid

		DELETE [kin_doc_category] WHERE kincategoryid=@kincategoryid 		
	END
	ELSE
	BEGIN
		RETURN (-2)
	END

	IF @@ERROR<>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END





GO
