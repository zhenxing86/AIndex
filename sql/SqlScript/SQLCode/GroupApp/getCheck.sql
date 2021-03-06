USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[getCheck]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 获取某月某日的晨检结果  
-- =============================================  
CREATE PROCEDURE [dbo].[getCheck]
	@bid int,
	@day DATE  
AS
BEGIN  
	SET NOCOUNT ON
	;WITH	CET0 AS
	(
		SELECT stuid,zz,CASE WHEN tw >= 37.8 And ',' + isnull(zz,'')+',' like '%,1,%' THEN '体温偏高' ELSE '正常' END tw
			FROM mcapp.dbo.stu_mc_day 
			where CheckDate = @day
	)
select sm.zz as result, CASE WHEN ISNULL(sm.zz,'') = '' THEN 0 else 1 end [status], sm.tw 
	FROM HealthApp.dbo.BaseInfo bi 
		inner join CET0 sm 
			on bi.id = @bid 
			and bi.[uid] = sm.stuid 
END      

GO
