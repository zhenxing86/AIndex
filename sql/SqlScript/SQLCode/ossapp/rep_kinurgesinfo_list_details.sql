USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kinurgesinfo_list_details]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kinurgesinfo_list_details]
@urgesftime datetime
,@urgesltime datetime
 AS 

select u.kid,kname,dotime,'' urgesday,info from dbo.urgesfee u
left join dbo.kinbaseinfo k on k.kid=u.kid



GO
