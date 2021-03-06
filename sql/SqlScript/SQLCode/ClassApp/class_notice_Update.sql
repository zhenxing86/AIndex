USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_Update]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改公告
--项目名称：ClassHomePage
--说明：
--时间：-8-23 9:44:05
------------------------------------
Alter PROCEDURE [dbo].[class_notice_Update]
@noticeid int,
@title nvarchar(100),
@classid int,
@content ntext,
@userid int,
@classlist nvarchar(200),
@isadminormaster bit

 AS 
	
	DECLARE @kid INT
	SELECT @kid=kid FROM basicdata..[user] where userid=@userid 
	
  Declare @cids Table (cid int)
  Insert Into @cids(cid)
    Select col From CommonFun.dbo.f_split(@classlist,',')

  Delete a
    From class_notice_class a
    Where Not Exists(Select * From @cids b Where a.classid = b.cid)
      and a.noticeid = @noticeid

  Insert Into class_notice_class(noticeid, classid)
    Select @noticeid, cid
      From @cids a
      Where Not Exists (Select * From class_notice_class b Where b.noticeid = @noticeid and a.cid = b.classid)

	UPDATE class_notice SET 
	[title] = @title,[classid] = @classid,[content] = @content
	WHERE noticeid=@noticeid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END

GO
