USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_reset]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[addservice_reset]

as 
create table #temp
(
xkid int
,xpname varchar(30)
,xa1 int
,xa2 int
,xa3 int
,xa4 int
,xa5 int
,xa6 int
,xa7 int
,xa8 int
,xprice float
)



insert into #temp (xkid)
select distinct kid from addservice 
where describe='开通' and a1 is null


update #temp set xpname='套餐'+right(a1,1)
,xa1=a1,xa2=a2,xa3=a3,xa4=a4,xa5=a5,xa6=a6,xa7=a7,xa8=a8
,xprice=price
from #temp t
left join feestandard f on t.xkid=f.kid


update addservice set pname=xpname
,a1=xa1,a2=xa2,a3=xa3,a4=xa4,a5=xa5,a6=xa6,a7=xa7,a8=xa8
,normalprice=xprice from #temp where xkid=kid

drop table #temp



GO
