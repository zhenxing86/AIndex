USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_detail_index]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kin_detail_index]
@area int
,@city int
,@timetype int
 AS

--1:0-1,2:1-2,3:2-3
declare @txttime1 datetime,@txttime2 datetime,@txtnow datetime

set @txtnow=GETDATE()

if(@timetype=1)
begin
set @txttime1=DATEADD(MM,-1,@txtnow)
set @txttime2=DATEADD(MM,0,@txtnow)
end
else if(@timetype=2)
begin
set @txttime1=DATEADD(MM,-2,@txtnow)
set @txttime2=DATEADD(MM,-1,@txtnow)
end
else if(@timetype=3)
begin
set @txttime1=DATEADD(YY,-10,@txtnow)
set @txttime2=DATEADD(MM,-3,@txtnow)
end



if(exists(select 1 from BasicData..Area where ID=@area and [level]=0) and @city=0)
  begin
   select 1,kid,kname,r.lastpaytime,DATEDIFF(dd,lasttime,GETDATE()),a.name,bfid,bfcount from rep_kin_payinfo r
  left join ossapp..agentbase a on a.ID=abid 
  where lasttime between @txttime1 and @txttime2 and province=@area and [status]='欠费'
  order by DATEDIFF(dd,lasttime,GETDATE()) desc
  
  end
 if(exists(select 1 from BasicData..Area where ID=@area and [level]=1) and @city<>@area)
  begin
  select 1,kid,kname,r.lastpaytime,DATEDIFF(dd,lasttime,GETDATE()),a.name,bfid,bfcount from rep_kin_payinfo r
  left join ossapp..agentbase a on a.ID=abid 
  where lasttime between @txttime1 and @txttime2 and city=@area and [status]='欠费'
  order by DATEDIFF(dd,lasttime,GETDATE()) desc
  end
  else
  begin 

  select 1,kid,kname,r.lastpaytime,DATEDIFF(dd,lasttime,GETDATE()),a.name,bfid,bfcount from rep_kin_payinfo r
  left join ossapp..agentbase a on a.ID=abid 
  where lasttime  between @txttime1 and @txttime2 and areaid=@area and [status]='欠费'
  order by DATEDIFF(dd,lasttime,GETDATE()) desc
 end
 

 
 


GO
