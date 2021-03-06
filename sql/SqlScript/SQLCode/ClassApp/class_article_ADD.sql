USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加班级文章 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-12 15:13:23
------------------------------------
CREATE PROCEDURE [dbo].[class_article_ADD]
@diycategoryid int,
@title nvarchar(100),
@userid int,
@author nvarchar(50),
@classid int,
@kid int,
@content ntext,
@publishdisplay int,
@istop int 


 AS 
	INSERT INTO [class_article](
	[diycategoryid],[title],[userid],[author],[classid],[kid],[content],[publishdisplay],[createdatetime],[viewcount],[commentcount],[level],[istop],[deletetag]
	)VALUES(
	@diycategoryid,@title,@userid,@author,@classid,@kid,@content,@publishdisplay,getdate(),0,0,1,@istop,1
	)

	--DECLARE  @LOGdescription nvarchar(300)	
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end
	--SET @LOGdescription='发表文章:'+@title

	DECLARE @objectid int
	set @objectid=@@IDENTITY

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	 --  EXEC class_actionlogs_ADD @userid,@author,@LOGdescription ,'28',@objectid,@userid,0,@classid  
	   RETURN @objectid
	END





GO
