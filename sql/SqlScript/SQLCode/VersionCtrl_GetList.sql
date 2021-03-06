USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[VersionCtrl_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：获取网站版本信息列表
--项目名称：网站版本管理
--说明：获取网站版本信息
--时间：2013-4-7 11:50:29

------------------------------------ 
CREATE PROCEDURE [dbo].[VersionCtrl_GetList]
@state int
AS
begin
     SELECT [id]
      ,[user_name]
      ,[batch_id]
      ,[update_time]
      ,[remark]
      ,[state]
	FROM [version_ctrl] v
    where v.[state] =@state
end




GO
