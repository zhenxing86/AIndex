USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManageattachs_ADD]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/29 17:05:42
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManageattachs_ADD]

@sid int,
@sname nvarchar(30),
@title nvarchar(30),
@filepath nvarchar(200),
@filename nvarchar(200),
@filesize nvarchar(200),
@filetype int

 AS 
	INSERT INTO [SchoolBus_SafeManageattachs](
	[sid],[sname],[title],[filepath],[filename],[filesize],[filetype],[createdatetime]
	)VALUES(
	@sid,@sname,@title,@filepath,@filename,@filesize,@filetype,getdate()
	)








GO
