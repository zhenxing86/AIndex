USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_statistics_stu]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[mc_sms_statistics_stu]
  @provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int,
	@bgndate datetime,
	@enddate datetime
	
AS
BEGIN
  SET NOCOUNT ON
  CREATE TABLE #T(smstype int, kid int)	
	CREATE TABLE #kid(kid int)
  DECLARE @flag int
  EXEC @flag = CommonFun.DBO.Filter_Kid @provinceid,@cityid,@areaid,@kname,@kid
  IF @flag = -1 
  BEGIN  
    INSERT INTO #T 
    SELECT smstype, kid
      from sms_mc
      where sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
        and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
        AND smstype IN(8,9,10,11)
  END
  ELSE 
  BEGIN
			INSERT INTO #T 
			SELECT smstype, sm.kid
				from sms_mc sm
					inner join #kid k on k.kid = sm.kid
				where sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
					and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
					AND smstype IN(8,9,10,11)
  END 
  
  select t.kid,bk.kname, 
         COUNT(CASE WHEN t.smstype = 8 then 1 else null end) dayyccnt,
         COUNT(CASE WHEN t.smstype = 9 then 1 else null end) carecnt,
         COUNT(CASE WHEN t.smstype = 10 then 1 else null end) monthcnt,
         COUNT(CASE WHEN t.smstype = 11 then 1 else null end) seasoncnt
    from #T t
      inner join BasicData..kindergarten bk on bk.kid = t.kid
    GROUP BY t.kid,bk.kname

END

GO
