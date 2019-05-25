USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kinurgesinfo_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kinurgesinfo_list]

 AS 

select 
sum(case when datediff(MM,dotime,getdate())=1 then 1 else 0 end) onemonth
,sum(case when datediff(MM,dotime,getdate())=2 then 1 else 0 end) twomonth
,sum(case when datediff(MM,dotime,getdate())=3 then 1 else 0 end) threemonth from dbo.urgesfee



GO
