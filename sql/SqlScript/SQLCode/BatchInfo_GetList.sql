USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[BatchInfo_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：获取网站基本信息列表
--项目名称：网站版本管理
--说明：
--时间：2013-4-7 11:50:29

------------------------------------ 
CREATE PROCEDURE [dbo].[BatchInfo_GetList]
AS
begin
     SELECT [batch_id]
      ,[site]
      ,[demo_url]
      ,[formal_url]
	FROM [batch_info]
end




GO
