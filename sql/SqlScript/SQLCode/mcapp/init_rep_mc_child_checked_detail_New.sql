USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_mc_child_checked_detail_New]    Script Date: 05/14/2013 14:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-04-20
-- Description:	
-- Memo:
EXEC init_rep_mc_child_checked_detail_New 12511,'2013-01-30'				
		stu_mc_month
		stu_mc_day	 			
*/  
CREATE PROCEDURE [dbo].[init_rep_mc_child_checked_detail_New] 
	@kid int  
 ,@dotime datetime  
AS   
BEGIN   
SET NOCOUNT ON
   
--根据KID删除当天现有数据  
delete dbo.rep_mc_child_checked_detail 
	where kid = @kid 
		and dotime >= CONVERT(varchar(10),@dotime,120)  
		and dotime < DATEADD(DD,1,CONVERT(varchar(10),@dotime,120)) 
  
create table #temp_mc(mstuid varchar(50), mcard varchar(30), mcdate datetime,
											mtw varchar(100), mzz varchar(200),medate datetime)
create table #temp(tcid int, tuid int, teaname nvarchar(100))
create table #tempuser(ucid int, usum int, udays int)
create table #tempclass(xcid int, xday int, xresult nvarchar(200))   

DECLARE @stu table(stuid varchar(50))
insert into @stu
	select distinct uc.userid
		FROM BasicData..user_class uc   
			inner join BasicData..class c 
				on uc.cid = c.cid
		WHERE c.kid = @kid
											  
insert into #temp_mc(mstuid, mcard, mcdate, mtw, mzz)  
	select DISTINCT sm.stuid, sm.card, sm.cdate, sm.tw, sm.zz 
		from dbo.stu_mc_day sm
			INNER JOIN @stu st on st.stuid = sm.stuid
		where sm.cdate >= CONVERT(varchar(10),@dotime,120)  
			and sm.cdate < DATEADD(DD,1,CONVERT(varchar(10),@dotime,120)) 
			
;WITH CET AS
(
	SELECT *,ROW_NUMBER()OVER(PARTITION BY mstuid ORDER BY CASE WHEN mzz <> '' then 0 else 1 end) row 
		FROM #temp_mc
)	
DELETE CET WHERE row <> 1		 	
  
--将幼儿所属班级所属的主班老师查询出来  
insert into #temp  
	select c.cid, b.userid, b.name 
		from BasicData..user_class uc  
			inner join BasicData..class c on uc.cid = c.cid  
			inner join BasicData..[user] u on u.userid = uc.userid  
			inner join BasicData..teacher t on t.userid = uc.userid  
			inner join BasicData..user_baseinfo b on b.userid = uc.userid  
		where c.kid = @kid 
			and u.usertype = 1 
			and t.title = '主班老师'  
  
--初始化用户UID  
insert into rep_mc_child_checked_detail
(
	kid, gradeid, gradename, cid, cname, userid, uname,
	checktime, temperature, result, status, tuserid, tname,
	mobile, recentlycount, classorder, outtime, dotime
) 
	output inserted.cid, DAY(inserted.checktime), ','+inserted.result
		into #tempclass(xcid, xday, xresult)         
select distinct c.kid, c.grade, g.gname, c.cid, 
		cname, uc.userid,b.name,s.mcdate, s.mtw,
		case when ISNULL(s.mzz,'') <> '' then mzz+',' else '' end,
		case when ISNULL(s.mzz,'') <> '' then 1 else 0 end, 
		tc.tuid, tc.teaname, b.mobile, 0, c.[order], medate, @dotime  
	from BasicData..user_class uc 
		OUTER APPLY(
								select TOP(1)tuid, teaname 
									from #temp tp 
									where tp.tcid = uc.cid
								)tc  
		left  join #temp_mc s on s.mstuid = uc.userid   
		inner join BasicData..class c on uc.cid = c.cid
		inner join BasicData..[user] u on u.userid = uc.userid AND u.usertype = 0    
		inner join BasicData..grade g on g.gid = c.grade and g.gid <> 38  
		inner join BasicData..user_baseinfo b on b.userid = uc.userid  
where c.kid = @kid   
 
DELETE #tempclass WHERE xday IS NULL 
 
 --删除旧数据
delete dbo.rep_mc_class_checked_sum 
	where kid = @kid 
		and years = year(@dotime) 
		and months = month(@dotime) 
		and [days] = day(@dotime)
	
create table #temp_sum
(
	tyears int, tmonths int, tdays int, tcid int, tcname nvarchar(100), torder int,
	tmcsum int, tremcsum int, tfs int, thlfy int, tks int, tlbt int, tfx int, 
	thy int, tszk int, tpz int, tjzj int, tfytx int, tjzdh int, texceptionsum int
)

--初始化一天
insert into #temp_sum(tyears, tmonths, tdays, tcid, tcname, torder)
select year(@dotime), month(@dotime), day(@dotime), c.cid, c.cname, g.[order] 
	from BasicData..class c 
		inner join BasicData..grade g 
			on g.gid = c.grade
	where c.kid = @kid 
		and c.deletetag = 1 
		and g.gid <> 38

--计算一个班级有多少幼儿
insert into #tempuser(ucid, usum)
	select c.tcid, COUNT(u.userid) 
		from #temp_sum c 
			inner join BasicData..user_class uc 
				on c.tcid = uc.cid
			inner join BasicData..[user] u 
				on uc.userid = u.userid
		where u.deletetag = 1 
			and u.usertype = 0 
		group by c.tcid

update #temp_sum 
	set tmcsum = usum 
	from #temp_sum ts 
		INNER JOIN #tempuser tu
			ON tu.ucid = ts.tcid

--查询幼儿的家长带回，服药提醒，和病症到临时表
;WITH CET AS
(
	select xcid, xday, COUNT(1) AS realcount, --实检人数
			sum(case when (xresult like '%,1,%') then 1 else 0 end) fs,  --发烧人数
			sum(case when (xresult like '%,2,%') then 1 else 0 end) ks,  --咳嗽人数
			sum(case when (xresult like '%,3,%') then 1 else 0 end) hlfy,--喉咙发炎人数  
			sum(case when (xresult like '%,4,%') then 1 else 0 end) lbt, --流鼻涕人数  
			sum(case when (xresult like '%,5,%') then 1 else 0 end) pz,  --皮疹人数  
			sum(case when (xresult like '%,6,%') then 1 else 0 end) fx,  --腹泻人数   
			sum(case when (xresult like '%,7,%') then 1 else 0 end) hy,  --红眼病人数   
			sum(case when (xresult like '%,8,%') then 1 else 0 end) szk, --重点观察病人数   
			sum(case when (xresult like '%,9,%') then 1 else 0 end) jzj, --剪指甲人数   
			sum(case when (xresult like '%,10,%') then 1 else 0 end) fytx, --服药提醒人数   
			sum(case when (xresult like '%,11,%') then 1 else 0 end) parentstake, --家长带回人数   
			sum(case when (isnull(xresult,'') <> ',') then 1 else 0 end) exceptionsum --异常总人数   
		from #tempclass
		group by xcid, xday
)
UPDATE #temp_sum 
	SET tremcsum = c.realcount,
	    tfs = c.fs,
	    tks = c.ks,
	    thlfy = c.hlfy,
	    tlbt = c.lbt,
	    tfx = c.fx,
	    thy = c.hy,
	    tszk = c.szk,
	    tpz = c.pz,
	    tjzj = c.jzj,
	    tfytx = c.fytx,
	    texceptionsum = c.exceptionsum,
	    tjzdh = c.parentstake
	FROM #temp_sum tp
		INNER JOIN CET c
			ON	tp.tdays = c.xday 
			and tp.tcid = c.xcid

---------------------------------汇总人数---------------------------
insert into dbo.rep_mc_class_checked_sum
(
	gorderby, years, months, [days], kid, cid, cname, totalcount, 
	realcount, notcome,	parentstake, exceptionsum, fs, hlfy, 
	ks, lbt, fx, hy, szk, pz, jzj, fytx,cdate
) 
select torder, year(@dotime), month(@dotime), tdays, @kid, tcid, tcname, tmcsum, 
		tremcsum, (tmcsum-tremcsum), tjzdh, texceptionsum, tfs, thlfy, 
		tks, tlbt, tfx, thy, tszk, tpz, tjzj, tfytx,@dotime 
	from #temp_sum
	order by [torder] asc, tdays asc
	
drop table #tempclass
drop table #tempuser
drop table #temp_sum   
drop table #temp_mc    
drop table #temp  

SET NOCOUNT OFF 
END
GO
