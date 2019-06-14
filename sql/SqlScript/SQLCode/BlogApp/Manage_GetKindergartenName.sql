USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetKindergartenName]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按地区取幼儿园名
--项目名称：zgyeyblog
--说明：
--时间：2008-12-19 16:00:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetKindergartenName]
@country int,
@privince nvarchar(50),
@city nvarchar(50)
AS	
	IF(@country=1)
	BEGIN
		SELECT kid,kname,kname FROM basicdata.dbo.Kindergarten WHERE  deletetag=1
	END 
	IF(@privince!='0')
	BEGIN
		SELECT kid,kname,kname FROM basicdata.dbo.Kindergarten WHERE Privince=@privince AND deletetag=1
	END
	IF(@city!='0')
	BEGIN
		SELECT kid, kname,kname FROM basicdata.dbo.Kindergarten WHERE City=@City AND deletetag=1
	END




GO
