USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_Update]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_Update]
@nid int,
@g_kid int,
@p_kid varchar(1000),
@p_kname varchar(max),
@title nvarchar(max),
@content varchar(max),
@istype int,
@inuserid int
 AS 
	UPDATE [group_notice] SET 

g_kid = @g_kid,p_kid = @p_kid,p_kname = @p_kname,
[title] = @title,[content] = @content,istype = @istype,inuserid = @inuserid
	WHERE nid=@nid 













GO
