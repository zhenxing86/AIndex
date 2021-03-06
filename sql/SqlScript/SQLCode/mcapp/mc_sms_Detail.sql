USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_Detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  yz  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================    
CREATE PROCEDURE [dbo].[mc_sms_Detail]  
	@kid int,   
	@date datetime,  
	@type int --(0 家长 1 老师 2 园长)  
   
AS  
BEGIN  
  SET NOCOUNT ON  
  create table #T(smstype int, tname varchar(15), name nvarchar(50),  
                  recmobile nvarchar(30), sendtime datetime, content nvarchar(300))  
  INSERT INTO #T  
  select sm.smstype, sn.tname, u.name, sm.recmobile, sm.sendtime, sm.content  
    from sms_mc sm  
      inner join smstype_name sn  
        on sn.smstype = sm.smstype  
      inner join BasicData..[user] u   
        on u.userid = sm.recuserid  
    where sm.kid = @kid  
      and sm.sendtime >= CONVERT(VARCHAR(10),@date,120)  
      and sm.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)  
      
    IF @type = 0 --家长  
    BEGIN  
      select tname, name, recmobile, sendtime, content  
        from #T  
        where smstype in (8,9,10,11)  
        order by tname, sendtime  
    END  
      
    IF @type = 1 --老师  
    BEGIN  
      select tname, name, recmobile, sendtime, content  
        from #T  
        where smstype in (3,4,5,6,7)  
        order by tname, sendtime  
    END  
      
    IF @type = 2 --园长  
    BEGIN  
      select tname, name, recmobile, sendtime, content  
        from #T  
        where smstype in (1,2)  
        order by tname, sendtime  
    END  
END  

GO
