USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuangzhang_Summary_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================         
--幼儿园取最好的那方面的20家来平均  
-- =============================================  
CREATE PROCEDURE [dbo].[yuangzhang_Summary_GetList]  
@kid int,  
@type int,--1 运营分析 2 教案分析 3保育分析  
@checktime datetime='1900-1-1'  
AS  
BEGIN  
declare @temp table  
(  
xid int,  
title varchar(100),  
typename varchar(100),  
subtitle varchar(100),  
counts int,  
unit varchar(50)  
)  
   
 declare @counts int=0,@ym varchar(10),@ymtime varchar(10),@checktimephoto datetime  
 set @ymtime=convert(varchar(7),dateadd(MM,-1,getdate()),120)  
   
 set @ym=replace(@ymtime,'-0','-')  
 --set @ym=month(dateadd(MM,-1,getdate()))  
 set @ym='('+@ym+')'  
   
 set @checktimephoto=dateadd(MM,-1,getdate())  
  
   
 if(@type=1)  
 begin  
 SELECT * INTO #kidPicCntForMonth FROM ClassApp..kidPicCntForMonth_V  
   
 ;WITH CET AS  
 (  
  select top 20 cnt from #kidPicCntForMonth WHERE upYearMonth = CONVERT(VARCHAR(7),@checktimephoto,120) order by cnt desc  
 )SELECT @counts = SUM(CNT)/20 FROM CET  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'班级照片上传数量'+@ym,'01','优秀幼儿园平均值',@counts,'张')  
 set @counts = 0  
 select @counts= CNT FROM #kidPicCntForMonth k WHERE upYearMonth = CONVERT(VARCHAR(7),@checktimephoto,120) AND kid=@kid  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'班级照片上传数量'+@ym,'01','我园上传情况',@counts,'张')  
   
   
 end     
   
 if(@type=2)  
 begin  
   
 select top 5 @counts=@counts+SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where  booktype=0 and yearmonth=@ymtime  
 group by kid order by SUM(notecount) desc  
 set @counts=@counts/5  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'教案数量分析'+@ym,'01','优秀幼儿园平均值',@counts,'篇')  
   
   
 select @counts=SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where kid=@kid and booktype=0 and yearmonth=@ymtime   
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'教案数量分析'+@ym,'01','我园',@counts,'篇')  
   
 ---------------------------------------------------------------  
 select top 5 @counts=@counts+SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where  booktype=1 and yearmonth=@ymtime  
 group by kid order by SUM(notecount) desc  
 set @counts=@counts/5  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(2,'教学随笔分析'+@ym,'02','优秀幼儿园平均值',@counts,'篇')  
   
   
 select @counts=SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where kid=@kid and booktype=1 and yearmonth=@ymtime  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(2,'教学随笔分析'+@ym,'02','我园',@counts,'篇')  
 ---------------------------------------------------------------  
 select top 5 @counts=@counts+SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where  booktype=2 and yearmonth=@ymtime  
 group by kid order by SUM(notecount) desc  
 set @counts=@counts/5  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(3,'教学反思分析'+@ym,'03','优秀幼儿园平均值',@counts,'篇')  
   
   
 select @counts=SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where kid=@kid and booktype=2 and yearmonth=@ymtime  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(3,'教学反思分析'+@ym,'03','我园',@counts,'篇')  
 ---------------------------------------------------------------  
 select top 5 @counts=@counts+SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where  booktype=3 and yearmonth=@ymtime  
 group by kid order by SUM(notecount) desc  
 set @counts=@counts/5  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(4,'观察记录分析'+@ym,'04','优秀幼儿园平均值',@counts,'篇')  
   
   
 select @counts=SUM(notecount) from ReportApp..rep_notebook_week r  
 inner join BasicData..[user] u on u.userid=r.userid   
 where kid=@kid and booktype=3 and yearmonth=@ymtime  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(4,'观察记录分析'+@ym,'04','我园',@counts,'篇')  
   
 end  
   
 if(@type=3)  
 begin  
   
   --declare @ymx varchar(100)
   --set @ymx=convert(varchar(7),@checktime,120)  
   --set @ymx='('+replace(@ymx,'-0','-')+')'  
   
 set @counts=0  
 select @counts=SUM(exceptionsum) from mcapp..rep_mc_class_checked_sum where kid=@kid and cdate=@checktime  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'保育分析','01','全园症状总人数',@counts,'人')  
   
 declare @cname varchar(100)  
 set @counts=0  
 select top 1 @counts=exceptionsum,@cname=cname from mcapp..rep_mc_class_checked_sum   
 where kid=@kid and cdate=@checktime order by exceptionsum desc  
   
 if(@counts=0)  
  set @cname=''  
   
 insert into @temp(xid,title,typename,subtitle,counts,unit)  
 values(1,'保育分析','01','症状高发班级：'+@cname,@counts,'人')  
   
 -------------------------------考勤-----------------------------------------------------------------------------  
  
declare @teaArriveCnt int  
;WITH CET AS  
(  
 SELECT ta.teaid  
   FROM mcapp.dbo.tea_at_day ta   
    WHERE ta.kid = @kid    
     and ta.cdate >= @checktime    
     and ta.cdate <= dateadd(dd,1,@checktime)    
  union    
  SELECT ta.teaid  
   FROM mcapp.dbo.tea_at_month ta   
    WHERE ta.kid = @kid    
     and ta.cdate >= @checktime    
     and ta.cdate <= dateadd(dd,1,@checktime)    
)  
SELECT @teaArriveCnt = COUNT(DISTINCT teaid) FROM CET  
  
insert into @temp(xid,title,typename,subtitle,counts,unit)  
select 1,'保育分析','01','幼儿出勤率' Title, 100*count(1)/cf.Totalcnt,'%'  
from mcapp..stu_mc_day sm   
 inner join BasicData..ChildCnt_ForKid cf  
  on sm.kid = cf.kid  
where sm.CheckDate = CONVERT(VARCHAR(10),@checktime,120)  
AND sm.kid = @kid  
GROUP BY cf.Totalcnt  
  
insert into @temp(xid,title,typename,subtitle,counts,unit)  
select 1,'保育分析','01','老师出勤率' Title, 100*convert(float,@teaArriveCnt)/convert(float,cf.Totalcnt),'%'  
from BasicData..TeacherCnt_ForKid cf    
where cf.kid = @kid  
  
    
   
   
------------------------------------------------------------------------------------------------------------  
   
   
   
 end    
   
      
    select xid,title,typename,subtitle,isnull(counts,0),unit from @temp  
END   
  
GO
