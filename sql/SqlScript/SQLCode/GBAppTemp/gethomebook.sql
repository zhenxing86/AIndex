USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[gethomebook]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--[gethomebook]

CREATE PROCEDURE [dbo].[gethomebook]
@hbid int
 AS 	

select * from homebook  where hbid=@hbid
select * from growthbook where hbid=@hbid
select * from familyinfo where gbid in(select gbid from growthbook where hbid=@hbid)
select * from childreninfo where gbid in(select gbid from growthbook where hbid=@hbid)
select * from foreword where hbid=@hbid
select * from advforeword where hbid=@hbid
select * from garteninfo where hbid=@hbid
select * from classinfo where hbid=@hbid
select * from celltarget where hbid=@hbid
select * from kidview where hbid=@hbid
select * from lifephoto where hbid=@hbid
select * from pworkphoto where hbid=@hbid
select * from tworkphoto where hbid=@hbid
select * from section where hbid=@hbid
select * from video where hbid=@hbid
select * from summary where hbid=@hbid
select * from advsummary where hbid=@hbid
select * from celllist where hbid=@hbid
select * from advcelllist where hbid=@hbid
select * from cellset
select * from sectionset
select * from moduleset







GO
