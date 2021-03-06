USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[GbErrorLog_Add]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的视频路径列表 
--exec ErrorLog_Add' 191598
-- =============================================
CREATE PROCEDURE [dbo].[GbErrorLog_Add]
@gbid char(100),
@typename char(100),
@url char(100),
@errmsg char(500)
AS

BEGIN

 insert into gberror_log(gbid,typename,url,errMsg) values(@gbid,@typename,@url,@errmsg) 

IF @@ERROR <> 0 
	BEGIN 
	   RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END


GO
