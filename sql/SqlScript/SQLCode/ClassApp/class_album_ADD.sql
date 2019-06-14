USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：创建班级相册 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 10:58:57
------------------------------------
CREATE PROCEDURE [dbo].[class_album_ADD]
@title nvarchar(50),
@description char(100),
@classid int,
@kid int,
@author nvarchar(50),
@userid int


 AS 

	INSERT INTO class_album(
	[title],[description],[photocount],[classid],[kid],[userid],[author],[createdatetime],[status]
	)VALUES(
	@title,@description,0,@classid,@kid,@userid,@author,getdate(),1
	)

	DECLARE @objectid int,@LOGdescription nvarchar(300)
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end	
	--SET @LOGdescription='创建了相册<a href="http://class.zgyey.com/'+cast(@classid as nvarchar(20))+'/classindex/albumphotolist_a'+CAST(@@IDENTITY AS nvarchar(20))+'.html"  target="_blank">:'+@title+'</a>'

	SET @objectid=@@identity
	IF @@ERROR <> 0 
	BEGIN 	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	  -- EXEC class_actionlogs_ADD @userid,@author,@LOGdescription,'21',@objectid,@userid,0,@classid	
	   RETURN @objectid
	END








GO
