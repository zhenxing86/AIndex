USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_ADD_v2]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：添加班级视频 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE PROCEDURE [dbo].[class_video_ADD_v2]
	@userid int,
	@classid int,
	@kid int,
	@title nvarchar(100),
	@description nvarchar(200),
	@filename nvarchar(200),
	@filepath nvarchar(500),
	@filesize int,
	@author nvarchar(50),
	@coverphoto nvarchar(200),
	@weburl nvarchar(500),
	@videotype int,
	@net int
 AS 	
BEGIN
	set nocount on
	declare @username nvarchar(20), @objectid int
	select @username=name from basicdata..[user] where userid=@userid 
	set @author=@username
	Begin tran   
	BEGIN TRY  
		INSERT INTO class_video
		(	userid,classid,kid,title,description,filename,filepath,filesize,viewcount,
			commentcount,uploaddatetime,author,coverphoto,status,weburl,videotype,net)
		VALUES(@userid,@classid,@kid,@title,@description,@filename,@filepath,@filesize,
						0,0,getdate(),@author,@coverphoto,1,@weburl,@videotype,@net)	
		set @objectid=@@IDENTITY
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1       
	end Catch     
	RETURN @objectid
END

GO
