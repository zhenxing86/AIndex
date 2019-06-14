USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_teachertrain_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[group_teachertrain_GetModel]
@ID int
 AS 


SELECT 
	1,g.ID,g.userid,u.[name]
,timetype
,(select Caption from BasicData..Dict d where d.ID=timetype)
,[level]
,(select Caption from BasicData..Dict d where d.ID=[level])
FROM group_teachertrain g
inner join BasicData..user_baseinfo u on u.userid=g.userid 

where  g.ID=@ID 











GO
