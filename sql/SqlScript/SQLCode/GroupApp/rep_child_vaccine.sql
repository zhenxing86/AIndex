USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_child_vaccine]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-8-5
-- Description: 疫苗接种情况
--[dbo].[rep_child_vaccine] 12511
-- =============================================
CREATE PROCEDURE [dbo].[rep_child_vaccine]
@kid int,
@mtype int = 0

AS
BEGIN
	SET NOCOUNT ON;
	
	if @mtype = 0
	
	select '掌握本园幼儿的疫苗接种情况是否符合国家免疫规划的安排<br />
	        从而在某些传染病高发期前能更有针对性地对易感幼儿进行预防干预，减少疾病伤害<br /><br />
	         <span style="color:#999;">2~3岁应接种：A群流脑疫苗、A+C群流脑疫苗、水痘疫苗、流行性感冒疫苗<br />
	          3~4岁应接种：脊髓灰质炎疫苗、流行性感冒疫苗（加强针）<br />
	          4~5岁应接种：流行性感冒疫苗（加强针）<br />
	          5~6岁应接种：A+C群流脑疫苗（加强针）、流行性感冒疫苗（加强针）</span>
	          'string
	          
	 if @mtype = 1
	 select '掌握本园幼儿的疫苗接种情况是否符合国家免疫规划的安排<br />
	        从而在某些传染病高发期前能更有针对性地对易感幼儿进行预防干预，减少疾病伤害'string
	  ----------------------------------------------
	          
	 select '托班（2~3岁）'grade,
	        15 do,
	        3 undo
	  UNION ALL
	  select '小班（3~4岁）'grade,
	        33 do,
	        1 undo
	  UNION ALL
	  select '中班（4~5岁）'grade,
	        31 do,
	        0 undo
	   UNION ALL
	  select '大班（5~6岁）'grade,
	        29 do,
	        5 undo
	        
	 	  ----------------------------------------------
	          
	
	--select case when c.grade in(34,97) then '托班'
 --             when c.grade = 35 then '小班'
 --             when c.grade = 36 then '中班'
 --             when c.grade =37 then '大班' else null end grade,
 --        u.userid,
 --        uh.hid
 --   into #t
	--  from [healthapp].[dbo].[hc_user_health] uh
	--  left join BasicData..[user] u
	--    on uh.userid = u.userid
	--  left join BasicData..user_class uc
 --      on uh.userid = uc.userid
 --   left join BasicData..class c
 --      on uc.cid = c.cid
	--where u.kid = @kid
	--  and u.deletetag = 1
	  
	-------------------------------------------------
	
	--	select case when c.grade in(34,97) then '托班（2~3岁）'
 --             when c.grade = 35 then '小班（3~4岁）'
 --             when c.grade = 36 then '中班（4~5岁）'
 --             when c.grade =37 then '大班（5~6岁）' else null end grade,
 --           COUNT(u.userid)tcnt
 --   into #p
	--  from  BasicData..[user] u
	--   left join BasicData..user_class uc
 --      on u.userid = uc.userid
 --   left join BasicData..class c
 --      on uc.cid = c.cid
       
	--where u.kid = @kid
	--  and u.deletetag = 1
	--  and u.usertype = 0
	  
	--group by grade
	  
	-- ------------------------------------------------
	  
	-- select t.userid,
	--        COUNT(case when t.hid in (1,2,3,4)then t.userid else null end)cnt
	--   into #t1     
	--   from #t t
	--   where t.grade = '托班'
	--   group by userid
	--   having COUNT(case when t.hid in (1,2,3,4)then t.userid else null end) >=4
	   
	-- select t.userid,
	--        COUNT(case when t.hid in (1,2,3,4,5)then t.userid else null end)cnt
	--   into #t2     
	--   from #t t
	--   where t.grade = '小班'
	--   group by userid
	--   having COUNT(case when t.hid in (1,2,3,4,5)then t.userid else null end) >=5

	-- select t.userid,
	--        COUNT(case when t.hid in (1,2,3,4,5,6)then t.userid else null end)cnt
	--   into #t3     
	--   from #t t
	--   where t.grade = '中班'
	--   group by userid
	--   having COUNT(case when t.hid in (1,2,3,4,5,6)then t.userid else null end) >=6
	   
	-- select t.userid, 
	--        COUNT(case when t.hid in (1,2,3,4,5,6,7,8,9)then t.userid else null end)cnt
	--   into #t4   
	--   from #t t
	--   where t.grade = '大班'
	--   group by userid
	--   having COUNT(case when t.hid in(1,2,3,4,5,6,7,8,9)then t.userid else null end) >=9
	   
	-- ---------------------------------------------
	 
	-- select '托班（2~3岁）'grade,
	--        count(distinct t1.userid)do,
	--        1 undo
	--  into #result
 --   from #t1 t1
    
 --  UNION ALL
   
 --  select '小班（3~4岁）'grade,
	--        count(distinct t2.userid)do,
	--        1 undo
	--  from #t2 t2
	  
	--  UNION ALL
	  
	--  select '中班（4~5岁）'grade,
	--        count(distinct t3.userid)do,
	--        1 undo
	--  from #t3 t3
	  
	--  UNION ALL
	  
	--  select '大班（5~6岁）'grade,
	--        count(distinct t4.userid)do,
	--        1 undo
	--  from #t4 t4
	  
	  
	--    update r
	--      set r.undo = p.tcnt - r.do
	--    from #result r
	--    inner join #p p
	--      on r.grade = p.grade
	  
	  
	--  select * from #result
   
	-- ----------------------------------------------
	     
 --    drop table #result,#t,#p,#t1,#t2,#t3,#t4                                                                                        
END 
 
GO
