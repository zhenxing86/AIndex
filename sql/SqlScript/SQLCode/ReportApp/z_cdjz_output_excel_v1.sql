USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[z_cdjz_output_excel_v1]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[z_cdjz_output_excel_v1]
@kid int
AS		


declare @time1 datetime='2013-7-1',@time2 datetime='2014-1-1'

			
select kid  xkid,kname xkname
into #pkid
from basicdata..kindergarten
where kid=@kid	
				
;with cet as
(
select	s1.ID, s1.uid,case when CONVERT(varchar(10),s1.dotime,120) = CONVERT(varchar(10),s2.dotime,120) then null else s1.ftime end ftime ,
				ISNULL(s2.dotime,s1.ltime)ltime 
	from LogData..ossapp_addservice_log s1 
	left join LogData..ossapp_addservice_log s2
	on s1.dotime<= s2.dotime 
	and s1.ltime > s2.dotime
	and s2.dotime >= s1.dotime 
	and s2.describe='关闭'
	and s1.[uid] = s2.[uid]
	--inner join basicdata..[user] u on u.userid=s1.[uid]  
	inner join #pkid on xkid=s1.kid
	where s1.describe='开通'
),
cet1 as
(
SELECT MIN(s1.ID)ID,s1.uid,	
				case when s1.ftime > s2.ftime then s2.ftime else s1.ftime end ftime, 
				case when s1.ltime < s2.ltime then s2.ltime else s1.ltime end ltime 
	FROM cet AS S1  
		LEFT JOIN cet AS S2  
			ON S1.ID <> S2.ID  
			and s1.uid = s2.uid
			AND S2.ltime > S1.ftime 
			AND S2.ftime < S1.ltime 
			and s1.ID > s2.ID 
	where CONVERT(varchar(10),s1.ftime,120)<> CONVERT(varchar(10),s1.ltime,120)
		and s1.ftime is not null
		GROUP BY s1.uid,case when s1.ftime > s2.ftime then s2.ftime else s1.ftime end, 
				case when s1.ltime < s2.ltime then s2.ltime else s1.ltime end 
			--	ORDER BY uid,ftime
)
SELECT s1.uid,	
				case when s1.ftime > s2.ftime then s2.ftime else s1.ftime end ftime, 
				case when s1.ltime < s2.ltime then s2.ltime else s1.ltime end ltime 
				into #T		
	FROM cet1 AS S1  
		LEFT JOIN cet1 AS S2  
			ON S1.ID <> S2.ID  
			and s1.uid = s2.uid
			AND S2.ltime > S1.ftime 
			AND S2.ftime < S1.ltime 
			and s1.ID > s2.ID 
	where CONVERT(varchar(10),s1.ftime,120)<> CONVERT(varchar(10),s1.ltime,120)
		and s1.ftime is not null
		GROUP BY s1.uid,case when s1.ftime > s2.ftime then s2.ftime else s1.ftime end, 
				case when s1.ltime < s2.ltime then s2.ltime else s1.ltime end 
				ORDER BY uid,ftime
				
				
			
				
				
			update #T set ltime=a.dotime from ossapp..addservice  a
				left join #T t on t.[uid]=a.[uid]
				inner join #pkid on xkid=kid
				where describe='关闭'	
				
			update #T set ltime=l.outtime from BasicData.dbo.leave_kindergarten  l
				left join #T t on t.[uid]=l.userid
				inner join #pkid on xkid=kid
				
			update #T set ltime=a.ltime from ossapp..addservice  a
				left join #T t on t.[uid]=a.[uid]
				inner join #pkid on xkid=kid
				where  describe='开通'
					
			insert into #T ([uid],ftime,ltime)
			select a.[uid],a.ftime,a.ltime from ossapp..addservice a
				left join #T t on t.[uid]=a.[uid]
				inner join #pkid on xkid=kid
			where t.[uid] is null
		
			
			 delete #T  where ftime<@time1
				
				select max(k.xkname) kname,isnull(max(u.name),'') uname
				,isnull(MAX(isnull(c.cname,d.cname)),'') cname,isnull(a.describe,'') isvip
				,DATEDIFF(dd,min(t.ftime),case when MAX(t.ltime)<=@time2 then MAX(t.ltime) else @time2 end) cntime
				,u.deletetag
				 from #T t
				 left join basicdata..User_Child d on d.userid=t.[uid]
				 left join basicdata..[user] u on u.userid=t.[uid]
				 left join basicdata..leave_kindergarten l on l.userid=u.userid
				 left join basicdata..class c on c.cid=l.cid
				 left join ossapp..addservice a on a.[uid]=d.userid
				 inner join #pkid k on xkid=u.kid or xkid=l.kid 
				 where isnull(a.describe,'关闭')='关闭'  --and u.deletetag=1
				group by t.[uid],a.describe,d.userid,u.deletetag 
				having DATEDIFF(dd,min(t.ftime),case when MAX(t.ltime)<=@time2 then MAX(t.ltime) else @time2 end) between 15 and 30
				order by MAX(d.cname)
				
			
				
				
	drop table #pkid,#T
	

GO
