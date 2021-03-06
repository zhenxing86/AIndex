USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMS_CountReport]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：
--项目名称：
--说明：
--时间：2009-3-2 15:20:13
--[SMS_CountReport] 1,2011,10,'1'
--[SMS_CountReport] 2,2011,10,'1'
--[SMS_CountReport] 3,2011,10,'1'
-----------------------------------
CREATE PROCEDURE [dbo].[SMS_CountReport]
@querytype int,
@year int,
@month int,
@orderstr int
 AS 	

if(@querytype=1)
begin
	select t2.title,sum(smscount) smscount,sum(childcount) childcount 
from reportapp..rep_smscount t1,basicdata..area t2 
where t1.[year]=@year and t1.[month]=@month and t1.childcount>20 and t1.area=t2.id group by t2.title
order by t2.title, childcount desc
end
else if (@querytype=2)
begin
select t2.title,sum(smscount) smscount,sum(childcount) childcount from reportapp..rep_smscount t1,basicdata..area t2 
where t1.[year]=@year and t1.[month]=@month and t1.childcount>20 and  t1.province=t2.id group by t2.title
order by childcount desc
end
else if (@querytype=3)
begin
select kmp.dbo.areacaptionfromid(province),kmp.dbo.areacaptionfromid(area), kname,kid,smscount,childcount 
from reportapp..rep_smscount t1 where t1.[year]=@year and t1.[month]=@month and  t1.childcount>20 order by province,area
end



GO
