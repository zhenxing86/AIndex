USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[ActionLogSyn]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ActionLogSyn]
 AS 

INSERT INTO [KWebCMS].[dbo].[actionlogs_history]
           ([userid]
           ,[usertype]
           ,[actionmodul]
           ,[actionobjectid]
           ,[actiondesc]
           ,[actiondatetime]
           ,[kid])
    select a.[userid]
           ,a.[usertype]
           ,[actionmodul]
           ,[actionobjectid]
           ,[actiondesc]
           ,[actiondatetime] ,u.siteid 
from [KWebCMS]..actionlogs a 
left join [KWebCMS]..site_user u on a.userid=u.userid

delete [KWebCMS]..actionlogs





GO
