USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_GetGradeListByUserID]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		liaoxin
-- Create date: 2011-6-29
-- Description:	获取指定用户的年纪列表 
--exec BasicData_GetGradeListByUserID 191598
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_GetGradeListByUserID]
@userid int
AS
BEGIN
  SELECT gid,gname from basicdata..grade  where gid in(select distinct(t1.grade) from  basicdata..user_class  t2 left  join  basicdata..class t1 on t2.cid=t1.cid  where t2.userid=@userid)

END





GO
