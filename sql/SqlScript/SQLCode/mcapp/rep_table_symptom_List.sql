USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_symptom_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rep_table_symptom_List] 
 @page int
,@size int
,@kid int
,@cid int
,@checktime1 datetime
,@checktime2 datetime
 AS 

create table #temp
(
ym varchar(20)
,fs int
,hlfy int
,ks int
,lbt int
,fx int
,hy int
,szk int
,pz int
,fytx int
,jzj int
)
 insert into #temp(ym,fs,hlfy,ks,lbt,fx,hy,szk,pz,fytx,jzj)
 select convert(varchar,years)+'-'+convert(varchar,months)
 ,sum(fs),sum(hlfy),sum(ks),sum(lbt),sum(fx),sum(hy),sum(szk),sum(pz),sum(fytx),sum(jzj)
 from rep_mc_class_checked_sum
 where kid =@kid and (cid=@cid or @cid=-1) 
 and cdate between @checktime1 and @checktime2
 group by years,months
 
 

 
 
 
  insert into #temp(ym,fs,hlfy,ks,lbt,fx,hy,szk,pz,fytx,jzj)
  select '合计',sum(fs),sum(hlfy),sum(ks),sum(lbt),sum(fx),sum(hy),sum(szk),sum(pz),sum(fytx),sum(jzj)
 from #temp
 
 

 select * from #temp
 
 
 drop table #temp
 


GO
