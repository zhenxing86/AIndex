USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[deletegrowthbook]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--[deletegrowthbook] 23

CREATE PROCEDURE [dbo].[deletegrowthbook]
@gbid int
 AS 	


delete  from familyinfo where gbid=@gbid
delete  from childreninfo where gbid=@gbid

delete  from lifephoto where gbid=@gbid
delete  from pworkphoto where gbid=@gbid
delete  from tworkphoto where gbid=@gbid
delete  from section where gbid=@gbid
delete  from video where gbid=@gbid
delete  from summary where gbid=@gbid
delete  from advsummary where gbid=@gbid
delete from celllist where gbid=@gbid
delete  from advcelllist where gbid=@gbid

delete from growthbook where gbid=@gbid


/*
select * from growthbook
declare @gbid int
set @gbid=72

select *  from familyinfo where gbid=@gbid
select *   from childreninfo where gbid=@gbid

select *   from lifephoto where gbid=@gbid
select *   from pworkphoto where gbid=@gbid
select *   from tworkphoto where gbid=@gbid
select *   from monthsection where gbid=@gbid

select *   from summary where gbid=@gbid
select *   from advsummary where gbid=@gbid
select *  from celllist where gbid=@gbid
select *   from advcelllist where gbid=@gbid

select *  from growthbook where gbid=@gbid


*/







GO
