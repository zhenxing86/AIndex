USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[SetReportAudit]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetReportAudit] 
	@smsid varchar(max)
as

Create table #temp
(
seid int
)

set @smsid=@smsid+','


while(charindex(',',@smsid)<>0)  
begin  
   insert into #temp
   select  (substring(@smsid,1,charindex(',',@smsid)-1))
    
   set   @smsid  =  stuff(@smsid,1,charindex(',',@smsid),'')  
end  


update sms..sms_message set [Status]=0  from #temp where smsid=seid --and istime=0

update sms..sms_message_temp set [Status]=0  from #temp where smsid=seid-- and istime=1

drop  table #temp
GO
