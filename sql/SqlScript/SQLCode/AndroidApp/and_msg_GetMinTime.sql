USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_msg_GetMinTime]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_msg_GetMinTime] 
AS

SELECT min([sent_time])
	FROM [AndroidApp].[dbo].[and_msg]
	where send_status=0

--大于20秒后，没发送的，一路当成已发送
update [AndroidApp].[dbo].[and_msg] set send_status=2 
where DATEDIFF(ss,sent_time,GETDATE())>2000 and send_status=0

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取最近一次推送时间，并且把超过20秒的数据自动设置为推送失败' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_GetMinTime'
GO
