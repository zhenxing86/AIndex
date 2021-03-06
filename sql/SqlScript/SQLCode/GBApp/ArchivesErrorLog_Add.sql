USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesErrorLog_Add]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：记录制作成长档案失败的日志
--项目名称：offlinegrowfactory（成长档案自动生成服务）/localgrowfactory（成长档案制作工厂）
--说明：下载成长档案
--时间：2013-1-19 11:50:29
--exec [ArchivesErrorLog_Add] 18579,'jonk','offlinegrowfactory','制作失败：index.res不存在','2013-1-19 11:50:29'
------------------------------------ 
CREATE PROCEDURE [dbo].[ArchivesErrorLog_Add]
@gbid int,
@userName char(50),
@project char(50),
@errorMsg char(500),
@errorTime DateTime
AS

BEGIN

 insert into [GBApp]..[archives_error_log](
      [gbid]
      ,[user_name]
      ,[project]
      ,[error_msg]
      ,[error_time])
values(@gbid,@userName,@project,@errorMsg,@errorTime)

declare @objId int
set @objId=@@IDENTITY

IF @@ERROR <> 0 
	BEGIN 
	   RETURN -1
	END
	ELSE
	BEGIN
		RETURN Isnull(@objId, 0)
	END
END




GO
