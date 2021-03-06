USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[TNB_ChapterRemark_ADD]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE  PROCEDURE [dbo].[TNB_ChapterRemark_ADD]
  @chapterid int,
 @remarkcontent varchar(400),
 @userid int
 
 AS 
	INSERT INTO [TNB_ChapterRemark](
  [chapterid],
 [remarkcontent],
 [userid],
 [username],
 [commentdatetime],
 [deletetag])
select top 1 @chapterid,@remarkcontent,@userid,u.[name],convert(varchar,getdate(),120),1 
from  BasicData..[user] u 
where u.userid=@userid and u.deletetag=1
 	
	

    declare @remarkid int
	set @remarkid=@@IDENTITY
	RETURN @remarkid

GO
