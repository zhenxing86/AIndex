USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetClassName]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取班级
--项目名称：zgyeyblog
--说明：
--时间：2008-12-24 15:16:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetClassName]
@kid int
AS
	SELECT cid,cname FROM basicdata.dbo.class WHERE kid=@kid AND deletetag=1 ORDER BY [Order]



GO
