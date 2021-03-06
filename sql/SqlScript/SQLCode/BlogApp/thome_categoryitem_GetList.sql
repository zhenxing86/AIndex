USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_categoryitem_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-04 16:29:22
------------------------------------
CREATE PROCEDURE [dbo].[thome_categoryitem_GetList]
@userid int,
@categoryid int
 AS
DECLARE @KID int
	DECLARE @TempID int
	DECLARE @KItemCount int	

	SELECT @TempID = count(1) FROM thome_categoryitem 
	WHERE userid=@userid and categoryid = @categoryid
	
	SELECT @KID = t2.kid FROM BasicData.dbo.user_bloguser t1 inner join BasicData.dbo.[user] t2 on t1.userid=t2.userid WHERE t1.bloguserid=@userid

	SELECT @KItemCount = count(1) FROM thome_tmpitem 
	WHERE kid=@KID
	
	IF(@TempID=0)
	BEGIN
		IF(@KItemCount>0)
		BEGIN
			INSERT INTO thome_categoryitem(categoryid,userid, title,resultlevel) 
			SELECT @categoryid,@userid,title,1 FROM thome_tmpitem WHERE (kid=@KID) and status=1
		END
		ELSE
		BEGIN
			INSERT INTO thome_categoryitem(categoryid,userid, title,resultlevel) 
			SELECT @categoryid,@userid,title,1 FROM thome_tmpitem WHERE (kid=0) and status=1
		END
	END
	
	SELECT
	itemid,categoryid,userid,title,resultlevel
	 FROM thome_categoryitem
	WHERE userid=@userid and categoryid = @categoryid

GO
