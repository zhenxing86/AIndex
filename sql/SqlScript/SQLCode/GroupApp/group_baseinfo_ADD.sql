USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_baseinfo_ADD]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/6 10:39:26
------------------------------------
CREATE PROCEDURE [dbo].[group_baseinfo_ADD]
@gid int output,
@kid int,
@name nvarchar(50),
@nickname nvarchar(50),
@descript nvarchar(100),
@logopic nvarchar(200),
@mastename nvarchar(50),
@inuserid int,
@intime datetime,
@order int,
@deletetag int

 AS 
	INSERT INTO [group_baseinfo](
	[kid],[name],[nickname],[descript],[logopic],[mastename],[inuserid],[intime],[order],[deletetag]
	)VALUES(
	@kid,@name,@nickname,@descript,@logopic,@mastename,@inuserid,@intime,@order,@deletetag
	)
	SET @gid = @@IDENTITY



GO
