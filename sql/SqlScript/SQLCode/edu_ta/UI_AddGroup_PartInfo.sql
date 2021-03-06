USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_AddGroup_PartInfo]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：查询记录信息 
--项目名称：ArticleType
------------------------------------
create PROCEDURE [dbo].[UI_AddGroup_PartInfo]

 AS
 DECLARE @tp TABLE
 (
		pc int
 )
 insert into @tp
 select kid from dbo.gartenlist 

 
 DECLARE @pct int
 set @pct = 0
select @pct = count(1) from fchedu118..group_partinfo 

 if(@pct=0)
 begin
 insert into fchedu118..group_partinfo (g_kid,name,[order])
 select t1.kid,t1.kname,@pct from dbo.gartenlist t1
 left join fchedu118..group_partinfo t2
 on  t2.g_kid = t1.kid where g_kid is null
 end
 else
 begin
 insert into fchedu118..group_partinfo (g_kid,name,[order])
 select t1.kid,t1.kname,( select max( t3.[order]) from  fchedu118..group_partinfo t3 ) from dbo.gartenlist t1
 left join fchedu118..group_partinfo t2
 on  t2.g_kid = t1.kid where g_kid is null
 end

 
	RETURN 0






GO
