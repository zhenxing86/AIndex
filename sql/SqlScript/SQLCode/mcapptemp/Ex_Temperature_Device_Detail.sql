USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[Ex_Temperature_Device_Detail]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	
	EXEC Ex_Temperature_Device -1,-1,-1,null,8812,'2013-09-05','2013-09-05'
	exec Ex_Temperature_Device_Detail 12511,'2013-09-05 00:00:00','2013-09-05 00:00:00',1,'08'
*/
CREATE PROC [dbo].[Ex_Temperature_Device_Detail]
	@kid int,
	@bgndate datetime, 
	@enddate datetime, 
	@type int,
	@gunid varchar(50)=null
AS
BEGIN
	SET NOCOUNT ON	
	CREATE TABLE #T(name varchar(50), cdate datetime, tw numeric(5,1), card varchar(50), gunid varchar(50))
	
			INSERT INTO #T(name, cdate, tw, card, gunid) 
			SELECT ub.name, sm.cdate, sm.tw, sm.card, sm.gunid
				from stu_mc_day	sm
					inner join BasicData.dbo.User_Child ub 
						on sm.stuid = ub.userid
						AND sm.kid = @kid
				where ISNUMERIC(sm.tw) = 1
					and sm.gunid = @gunid
					and ((@type = 1 and CAST(sm.tw AS numeric(5,1)) > 38) or (@type = 0 and CAST(sm.tw AS numeric(5,1)) < 35))					
					AND CAST(sm.tw AS NUMERIC(9,2)) <> 0			
					and sm.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
					and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)			
		  UNION ALL
			SELECT ub.name, sm.cdate, sm.tw, sm.card, sm.gunid
				from stu_mc_month	sm
					inner join BasicData.dbo.User_Child ub
						on sm.stuid = ub.userid
						AND sm.kid = @kid
				where ISNUMERIC(sm.tw) = 1
					and sm.gunid = @gunid
					AND CAST(sm.tw AS NUMERIC(9,2)) <> 0
					and ((@type = 1 and CAST(sm.tw AS numeric(5,1)) > 38) or (@type = 0 and CAST(sm.tw AS numeric(5,1)) < 35))					 
					and sm.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
					and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)	
	
	select	name, gunid, cdate, card, tw 
		from #T 
		order by gunid,cdate
	
END

GO
