USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetClassListByKid]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		liaoxin
-- Create date: 2011-6-29
-- Description:	获取指定幼儿园所以年级列表
--exec [BasicData_GetGradeListByKID] 58
-- =============================================
CREATE   PROCEDURE [dbo].[GetClassListByKid]
@kid int
AS
BEGIN
  SELECT gid,gname,cid,t2.[cname],t1.[order] from basicdata..grade t1  
inner join  basicdata..class  t2  on t1.gid=t2.grade where t1.gid<>38 and t2.kid=@kid and deletetag=1 order by  t1.[order] asc



END



GO
