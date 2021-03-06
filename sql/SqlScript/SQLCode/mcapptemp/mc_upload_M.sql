USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_upload_M]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
mc_upload_M -1,-1,-1,-1,0,'2013-07-20'

*/
CREATE PROC [dbo].[mc_upload_M]
	@provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int,
	@date datetime
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #result(kid int, kname varchar(50), Totalcnt int, uploadcnt int)	
	CREATE TABLE #kid(kid int)
  DECLARE @flag int
  EXEC @flag = CommonFun.DBO.Filter_Kid @provinceid,@cityid,@areaid,@kname,@kid
  
	IF @flag = -1 
	BEGIN
		INSERT INTO #result(kid, uploadcnt) 
		SELECT kid, count(DISTINCT stuid)  
			from stu_at_all_V 
			WHERE cdate >= CONVERT(VARCHAR(10),@date,120)
				and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
			group by kid	
	END
	ELSE
	BEGIN					
		INSERT INTO #result(kid, uploadcnt) 
		SELECT sm.kid, count(DISTINCT stuid)  
			from stu_at_all_V sm
				inner join #kid k on sm.kid = k.kid	
			WHERE sm.cdate >= CONVERT(VARCHAR(10),@date,120)
				and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)	
			group by sm.kid				
	END	
			
	update #result set Totalcnt = kc.Totalcnt, kname = k.kname  
		from #result r 
			inner join BasicData.dbo.ChildCnt_ForKid kc 
				on r.kid = kc.kid
			inner join BasicData.dbo.kindergarten k
				on r.kid = k.kid
				
	select *,CAST(1.0*uploadcnt/totalcnt as numeric(9,4)) uploadrate 
		from #result
		ORDER BY uploadrate 
END

GO
