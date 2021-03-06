USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_ADD]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/6 11:34:55
------------------------------------
CREATE PROCEDURE [dbo].[group_partinfo_ADD]
@pid int output,
@gid int,
@g_kid int,
@p_kid int,
@name nvarchar(100),
@nickname nvarchar(100),
@descript nvarchar(500),
@logopic nvarchar(200),
@mastername nvarchar(100),
@inuserid int,
@intime datetime,
@order int,
@deletetag int

 AS 
	INSERT INTO [group_partinfo](
	[gid],[g_kid],[p_kid],[name],[nickname],[descript],[logopic],[mastername],[inuserid],[intime],[order],[deletetag]
	)VALUES(
	@gid,@g_kid,@p_kid,@name,@nickname,@descript,@logopic,@mastername,@inuserid,@intime,@order,@deletetag
	)
	SET @pid = @@IDENTITY



GO
