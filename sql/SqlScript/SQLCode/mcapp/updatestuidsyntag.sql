USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[updatestuidsyntag]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[updatestuidsyntag]
@kid int
 AS 
	
--update t2 set syntag=1 from stuid_tmp t1 left join stuinfo t2 on t1.oid=t2.stuid

--delete stuid_tmp where devid='001251102' and kid=@kid
	 
--select * from stuid_tmp where devid='001251101'









GO
