USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_ADD]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_ADD]
@g_kid int,
@p_kid varchar(2000),
@p_kname varchar(max),
@title nvarchar(max),
@content varchar(max),
@istype int,
@inuserid int,
@username varchar(100)

 AS 
	INSERT INTO [group_notice](g_kid,p_kid,p_kname,
	[title],[content],istype,[inuserid],[intime],[deletetag],username
	)VALUES(
	@g_kid,@p_kid,@p_kname,@title,@content,@istype,@inuserid,getdate(),1,@username
	)

    declare @nid int
	set @nid=@@IDENTITY
	RETURN @nid



















GO
