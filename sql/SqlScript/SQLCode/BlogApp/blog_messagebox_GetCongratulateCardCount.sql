USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetCongratulateCardCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取温馨贺卡数 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-3-25 15:30:07
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetCongratulateCardCount]
@cardtype nvarchar(50)
 AS
	DECLARE @count int
	SELECT @count=count(1) FROM ResourceApp.dbo.CongratulateCard WHERE cardtype=@cardtype
	RETURN @count





GO
