USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_Update]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/2/6 11:34:55
------------------------------------
CREATE PROCEDURE [dbo].[group_partinfo_Update]
@pid int,
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
	UPDATE [group_partinfo] SET 
	[gid] = @gid,[g_kid] = @g_kid,[p_kid] = @p_kid,[name] = @name,[nickname] = @nickname,[descript] = @descript,[logopic] = @logopic,[mastername] = @mastername,[inuserid] = @inuserid,[intime] = @intime,[order] = @order,[deletetag] = @deletetag
	WHERE pid=@pid 








GO
