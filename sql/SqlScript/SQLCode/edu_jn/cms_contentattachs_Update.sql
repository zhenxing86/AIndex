USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--鐢ㄩ€旓細淇敼涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[cms_contentattachs_Update]
 @attid int,
 @contentid int,
 @title varchar(100),
 @filepath varchar(400),
 @filename varchar(200),
 @filesize varchar(200),
 @filetype int,
 @createdatetime datetime
 
 AS 
	UPDATE [cms_contentattachs] SET 
  [contentid] = @contentid,
 [title] = @title,
 [filepath] = @filepath,
 [filename] = @filename,
 [filesize] = @filesize,
 [filetype] = @filetype,
 [createdatetime] = @createdatetime
 	 WHERE attid=@attid 










GO
