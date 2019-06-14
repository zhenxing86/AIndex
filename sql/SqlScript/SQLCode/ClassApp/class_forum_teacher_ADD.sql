USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加教学交流 
--项目名称：classhomepage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_ADD]
@title nvarchar(50),
@contents ntext,
@userid int,
@author nvarchar(30),
@kid int,
@istop int,
@parentid int,
@isblogpost int,
@approve int

 AS 

	INSERT INTO class_forum_teacher(
	[title],[contents],[userid],[author],[kid],[createdatetime],[istop],[parentid],[approve],[status]
	)VALUES(
	@title,@contents,@userid,@author,@kid,getdate(),@istop,@parentid,@approve,1
	)
	declare @objectid int
	set @objectid=@@IDENTITY

	--DECLARE @description nvarchar(300)
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end	
	--IF(@parentid=0)
	--BEGIN
	--	SET @description='在教师交流发表了帖子'+@title
	--END
	--ELSE
	--BEGIN
	--	DECLARE @oldtitle nvarchar(50)
	--	SELECT @oldtitle=title FROM class_forum WHERE classforumid=@parentid
	--	SET @description='在教师交流回复了帖子'+@oldtitle
	--END

	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   --exec class_actionlogs_ADD @userid,@author,@description ,'32',@objectid,@userid,0,0
	   RETURN @objectid
	END












GO
