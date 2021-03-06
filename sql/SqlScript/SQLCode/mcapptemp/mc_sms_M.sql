USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_M]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      yz
-- Create date: 
-- Description:	
-- Memo:		
exec mc_sms_M -1,-1,-1,'',12511,'2013-07-11'

*/
CREATE PROC [dbo].[mc_sms_M]
	@provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int,
	@date datetime	
AS
BEGIN
  SET NOCOUNT ON
  CREATE TABLE #T(smsid int)	
	CREATE TABLE #kid(kid int)
  DECLARE @flag int
  EXEC @flag = CommonFun.DBO.Filter_Kid @provinceid,@cityid,@areaid,@kname,@kid
  IF @flag = -1 
  BEGIN
    INSERT INTO #T 
    SELECT DISTINCT smsid
      from sms_mc
      where sendtime >= CONVERT(VARCHAR(10),@date,120)
        and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
  END
  ELSE 
  BEGIN
    INSERT INTO #T 
    SELECT DISTINCT smsid
      from sms_mc sm
        inner join #kid k on k.kid = sm.kid
      where sendtime >= CONVERT(VARCHAR(10),@date,120)
        and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
  END
  
  select bk.kid, bk.kname, 
         COUNT(CASE WHEN sm.smstype in ('1','2')then 1 else null end) yzcnt,
         COUNT(CASE WHEN sm.smstype in ('3','4','5','6','7')then 1 else null end) teacnt,
         COUNT(CASE WHEN sm.smstype in ('8','9','10','11')then 1 else null end) stucnt
    from #T t
      inner join sms_mc sm on sm.smsid = t.smsid
      inner join BasicData..kindergarten bk on bk.kid = sm.kid
    GROUP BY bk.kid, bk.kname
END

GO
