USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_ADD]    Script Date: 2014/11/24 23:09:23 ******/
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
CREATE PROCEDURE [dbo].[cms_category_ADD]
  @title varchar(100),
 @gid int,
 @catcode varchar(100)
 
 AS 
	INSERT INTO [cms_category](
  [title],
 [gid],
 [catcode]
 
	)VALUES(
	
  @title,
 @gid,
 @catcode
 	
	)

    declare @catid int
	set @catid=@@IDENTITY
	RETURN @catid



GO
