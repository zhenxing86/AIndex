USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[user_health_GetModel]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[user_health_GetModel]
@growid Int
as
Set Nocount On

Select b.growid, a.userid, a.name, a.sex, b.height, b.weight, b.sight, b.indate
  From Basicdata.dbo.user_child a, HealthApp.[dbo].[hc_grow] b 
  Where a.userid = b.userid and b.byTeacher = 1 and b.growid = @growid



GO
