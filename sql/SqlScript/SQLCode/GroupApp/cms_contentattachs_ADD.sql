USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_ADD]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--鐢ㄩ€旓細澧炲姞涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[cms_contentattachs_ADD]
  @contentid int,
 @title varchar(100),
 @filepath varchar(400),
 @filename varchar(200),
 @filesize varchar(200),
 @filetype int,
 @createdatetime datetime
 
 AS 
	INSERT INTO [cms_contentattachs](
  [contentid],
 [title],
 [filepath],
 [filename],
 [filesize],
 [filetype],
 [createdatetime]
 
	)VALUES(
	
  @contentid,
 @title,
 @filepath,
 @filename,
 @filesize,
 @filetype,
 @createdatetime
 	
	)

    declare @attid int
	set @attid=@@IDENTITY
	RETURN @attid



GO
