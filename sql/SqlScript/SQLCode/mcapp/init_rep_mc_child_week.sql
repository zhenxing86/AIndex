USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_mc_child_week]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-05-06  
-- Description: 计算小朋友的健康指数,每个星期五定期执行
-- Memo:  EXEC init_rep_mc_child_week  '2013-09-20'
*/  
CREATE PROCEDURE [dbo].[init_rep_mc_child_week]
	@cdate1 datetime = null  
AS     
BEGIN     
SET NOCOUNT ON 

--只在星期五运行计算
IF @cdate1 IS NULL
SET @cdate1 = GETDATE()

IF DATEDIFF(day, '19000101' , @cdate1) % 7 +1 <> 5
return


--declare @cdate1 datetime = '2013-05-04'
;WITH CET AS
(
	select u.userid, sm.zz result, sm.CheckDate, 
			CASE WHEN ISNULL(sm.zz, '')='' THEN 0 ELSE 1 END status,
			case when (','+sm.zz +',' like '%,1,%') then 1 else 0 end fs,  --发烧
			case when (','+sm.zz +',' like '%,2,%') then 1 else 0 end ks,  --咳嗽
			case when (','+sm.zz +',' like '%,3,%') then 1 else 0 end hlfy,--喉咙发炎  
			case when (','+sm.zz +',' like '%,4,%') then 1 else 0 end lbt, --流鼻涕  
			case when (','+sm.zz +',' like '%,5,%') then 1 else 0 end pz,  --皮疹  
			case when (','+sm.zz +',' like '%,6,%') then 1 else 0 end fx,  --腹泻   
			case when (','+sm.zz +',' like '%,7,%') then 1 else 0 end hy,  --红眼病 
			case when (','+sm.zz +',' like '%,8,%') then 1 else 0 end szk, --重点观察   
			case when (','+sm.zz +',' like '%,9,%') then 1 else 0 end jzj, --剪指甲   
			case when (','+sm.zz +',' like '%,10,%') then 1 else 0 end fytx, --服药提醒   
			case when (','+sm.zz +',' like '%,11,%') then 1 else 0 end parentstake --家长带回 	
		from mc_kid_date_list mk 
			INNER JOIN [BasicData]..[user] u 
				on u.usertype = 0 
				and mk.cdate >= u.regdatetime
				and u.kid = mk.kid
			left join stu_mc_day sm 
				on mk.kid = sm.kid 
				and sm.CheckDate = mk.cdate
				and sm.stuid = u.userid
		where mk.cdate >= CONVERT(VARCHAR(7),DATEADD(MM,-2,@cdate1),120)+'-01'
			AND mk.cdate < CONVERT(VARCHAR(10),@cdate1,120)
)--select * from CET
,CET1 AS
(
	select userid,sum(fs)fs,sum(ks)ks,sum(hlfy)hlfy,sum(lbt)lbt,
					 sum(pz)pz,sum(fx)fx,sum(hy)hy,sum(szk)szk,sum(jzj)jzj,
					 sum(fytx)fytx,sum(parentstake)parentstake,
					 SUM(CASE WHEN status = 0 then 1 else 0 end)healthcnt,	
					 SUM(CASE WHEN status = 1 then 1 else 0 end)sickcnt,	
					 SUM(CASE WHEN CheckDate is null then 1 else 0 end)uncheckcnt
					 	
			FROM CET
			GROUP BY userid
) 
	SELECT *
		INTO #T
				from CET1	
		
	INSERT INTO dbo.rep_mc_child_week(userid,cdate,degree)
		select userid, CONVERT(VARCHAR(10),@cdate1,120), CASE WHEN  ISNULL(hy,0) = 0 
													AND ISNULL(parentstake,0) = 0 
													AND ISNULL(sickcnt,0) < 5
													AND ISNULL(uncheckcnt,0) < 3
													AND ISNULL(fytx,0) + ISNULL(fs,0) + ISNULL(szk,0) < 2
										THEN 5 
												WHEN  ISNULL(hy,0) = 0 
													AND ISNULL(sickcnt,0) < 10
													AND ISNULL(uncheckcnt,0) < 6
													AND ISNULL(fytx,0) + ISNULL(fs,0) + ISNULL(szk,0) < 5 
										THEN 4
										ELSE 3 END
			FROM #T 
/*
下面更新 体弱幼儿 数据 zz_counter.Isweak
	对幼儿的晨检评价分为2种：健康、体质偏弱
体质偏弱幼儿的选取规则：
1.	幼儿至入园以来每月健康指数为3星的月份占总月份的30%以上（参加晨检的月份超过6个月）
2.	参加晨检的月份不超过6个月的，连续两个月的健康指数为3星或累积有超过3个月的健康指数为3星，则可判定为体质偏弱幼儿
非体质偏弱幼儿即为健康幼儿
*/			
	select p.* into #T1 from #T t 
		cross apply
			(
				select userid, cdate, degree, CASE WHEN  DATEADD(MM,-6,@cdate1) > MIN(cdate)over() THEN 1 ELSE 0 END AS oversixmonth
					from rep_mc_child_week rm 
					where cdate > dateadd(mm,-6, @cdate1)
						and rm.userid = t.userid 			
			) p	

;WITH CET AS
(
select userid, CASE WHEN 1.0 * COUNT(case when degree = 3 then 1 else null end)/COUNT(1) > 0.3 THEN 1 ELSE 0 END isweek
	from #T1 
	where oversixmonth = 1 
	GROUP BY userid
)	
	UPDATE zz_counter 
		SET Isweak = c.isweek
		from zz_counter zc 
			INNER JOIN CET c 
				ON zc.userid = c.userid
				

	SELECT  o1.userid,O1.cdate, O1.degree AS degree,-- SUM(O2.degree) AS totalqty,
		CAST(AVG(1.*O2.degree) AS DECIMAL(12, 2)) AS avgqty,COUNT(1)as cnt
	INTO #T2
	FROM #T1 AS O1
		JOIN #T1 AS O2
			ON O2.cdate <= O1.cdate 
				and o2.cdate > dateadd(month,-3,o1.cdate)
				and o1.userid = o2.userid
				and O1.oversixmonth = 0 
				and O2.oversixmonth = 0 
	GROUP BY  o1.userid,O1.cdate, O1.degree
	
;WITH CET AS
(
	select	userid
		from #T2  
		where cnt > 8 
			and avgqty = 3  
		GROUP BY userid
union 		
	select 	userid
		from #T2 
		where degree = 3 
		GROUP BY userid 
		having COUNT(1)>	12	
),CET1 AS
(
	SELECT userid 
		FROM #T1 
		WHERE oversixmonth = 0 
		GROUP BY userid
)
update zz_counter 
	SET Isweak = CASE WHEN c.userid IS NULL THEN 0 ELSE 1 END
		from zz_counter zc 
			INNER JOIN CET1 c1 
				ON zc.userid = c1.userid
			left join CET c
				on zc.userid = c.userid

;with cet as
(
	select userid, 
					COUNT(case when degree = 3 then 1 else null end) as star3,
					COUNT(case when degree = 4 then 1 else null end) as star4,
					COUNT(case when degree = 5 then 1 else null end) as star5 
		from #T1 GROUP BY userid
)	update 	zz_counter 
		set star3 = c.star3,	
		    star4 = c.star4,
		    star5 = c.star5	
		from 	zz_counter zc 
			inner join cet c
				on zc.userid = c.userid
			
END

GO
