USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除一条公告 
--项目名称：ClassHomePage
--说明：
--时间：2011-7-1 9:44:05
------------------------------------
CREATE PROCEDURE [dbo].[class_notice_Delete]
@noticeid int,
@userid int,
@classid int
 AS 
	

		DECLARE @count int
		select @count=count(1) from class_notice_class where noticeid=@noticeid
		if(@count>1)
		begin
			delete class_notice_class where noticeid=@noticeid and classid=@classid
		end
		else
		begin
			delete class_notice_class where noticeid=@noticeid
			UPDATE class_notice SET status=-1 WHERE noticeid=@noticeid
			
			delete applogs..class_log where actionobjectid=@noticeid
		end

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END







GO
