USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[IsHasClassMusic]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[IsHasClassMusic]
	@ClassID varchar(50),
	@Path	varchar(200),
	@Title	varchar(100)
AS
	select count(ID) from classbackgroundmusic where classid=@ClassID and BackGroundMusicPath = @Path and BackGroundMusicTitle = @Title
	
	RETURN
GO
