USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[deletehomebook]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--[deletehomebook] 2764

CREATE PROCEDURE [dbo].[deletehomebook]
@hbid int
 AS 	


delete  from dbo.familyinfo where gbid in(select gbid from growthbook where hbid=@hbid)
delete  from childreninfo where gbid in(select gbid from growthbook where hbid=@hbid)

delete  from foreword where hbid=@hbid
delete  from advforeword where hbid=@hbid
delete  from garteninfo where hbid=@hbid
delete  from classinfo where hbid=@hbid
delete  from celltarget where hbid=@hbid

delete from kidview where hbid=@hbid

delete  from section where hbid=@hbid

delete  from summary where hbid=@hbid
delete  from advsummary where hbid=@hbid
delete from celllist where hbid=@hbid
delete  from advcelllist where hbid=@hbid

delete from growthbook where hbid=@hbid
delete from homebook where hbid=@hbid








GO
