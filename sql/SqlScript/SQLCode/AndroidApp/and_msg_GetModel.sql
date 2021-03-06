USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_msg_GetModel]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_msg_GetModel] 
@msgid bigint
AS

SELECT [ID]
      ,[taskid]
      ,[title]
      ,[contents]
      ,[push_type]
      ,[msg_type]
      ,[sent_time]
      ,[status]
      ,[userid]
      ,[tag]
      ,[msg_code]
      ,[sender]
      ,[send_status]
      ,[intime]
  FROM [AndroidApp].[dbo].[and_msg]
  where ID=@msgid
           
           

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取消息实体' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_GetModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_GetModel', @level2type=N'PARAMETER',@level2name=N'@msgid'
GO
