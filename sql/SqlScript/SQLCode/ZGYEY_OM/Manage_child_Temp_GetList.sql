USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_child_Temp_GetList]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Manage_child_Temp_GetList]
@Kid int
 AS 
SELECT [id]
      ,c.[kid]
      ,c.[classid]
      ,c.[loginname]
      ,c.[username]
      ,c.[gender]
      ,c.[birthday]
      ,c.[mobile]
      ,c.[enrollmentdate],account
  FROM [ZGYEY_OM].[dbo].[ChildTemp] c
left join BasicData..[user] u on c.loginname=u.account
where c.kid=@kid

GO
