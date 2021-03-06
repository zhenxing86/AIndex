USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_child_standard_grow]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-7-31
-- Description: 成长指标情况
--[dbo].[rep_child_standard_grow] 12511
-- =============================================
CREATE PROCEDURE [dbo].[rep_child_standard_grow]
@kid int,
@mtype int = 0

AS
BEGIN
	SET NOCOUNT ON;
	
	select '掌握本园幼儿在园期间的生长发育情况<br />能够及时地调整教育和饮食方案，让幼儿能够健康成长'string

	select '托班（2-3岁）'as 年级,
	       '98.1' as 平均身高,
	       '16.8'as 平均体重,
	       1 偏矮,
	       2 偏高,
	       0 偏胖,
	       1 偏瘦
	       
	 union all 

	select '小班（3-4岁）'as 年级,
	       '101.0' as 平均身高,
	       '17.3'as 平均体重,
	       3 偏矮,
	       2 偏高,
	       1 偏胖,
	       0 偏瘦
	       
	 union all 
	 
	select '中班（4-5岁）'as 年级,
	       '105.2' as 平均身高,
	       '18.1'as 平均体重,
	       0 偏矮,
	       0 偏高,
	       0 偏胖,
	       1 偏瘦
	       
	 union all 
	 
	select '大班（5-6岁）'as 年级,
	       '110.0' as 平均身高,
	       '18.9'as 平均体重,
	       1 偏矮,
	       2 偏高,
	       0 偏胖,
	       1 偏瘦
	       
	
 -- select datediff(month,u.birthday,GETDATE()) months,
 --        case when c.grade in(34,97) then '托班'
 --             when c.grade = 35 then '小班'
 --             when c.grade = 36 then '中班'
 --             when c.grade =37 then '大班' else null end grade,
 --        g.userid,
 --        u.gender,
 --        g.height,
 --        g.[weight],
 --        ROW_NUMBER()over(partition by g.userid order by g.indate desc)rown
 --  into #t
 --  from [healthapp].[dbo].[hc_grow] g
 --    inner join BasicData..[user] u
 --      on g.userid = u.userid
 --    left join BasicData..user_class uc
 --      on g.userid = uc.userid
 --    left join BasicData..class c
 --      on uc.cid = c.cid
 
 -- where u.kid = @kid
 --     and g.deletetag = 1
 --     and u.deletetag = 1
    
  
 --    select '托班（2-3岁）'年级,
 --          cast(avg(height)as numeric(4,1))平均身高,
 --          cast(avg([weight])as numeric(4,1))平均体重,
 --          COUNT(case when (height < 84.3 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or (height < 83.3 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or (height < 88.9 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36))
 --                       or (height < 87.9 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36))
 --                     then userid else null end) 偏矮,
 --          COUNT(case when (height > 95.8 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or (height > 94.7 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or (height > 98.7 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36)) 
 --                       or (height > 98.1 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36))
 --                     then userid else null end) 偏高,
 --          COUNT(case when ([weight] < 11.2 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30) )
 --                       or ([weight] < 10.6 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or ([weight] < 12.1 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36) )
 --                       or ([weight] < 11.7 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36))
 --                     then userid else null end) 偏瘦,
 --          COUNT(case when ([weight] > 15.3 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or ([weight] > 14.7 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 0 and 30)) 
 --                       or ([weight] > 16.4 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36)) 
 --                       or ([weight] > 16.1 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 30 and 36))
 --                     then userid else null end) 偏胖
                      
 --     into #result --------结果表          
      
                      
 --     from #t
 --     where grade = '托班'or ( grade is null and months between 0 and 36) 
      
 --  UNION ALL
   
 --       select '小班（3-4岁）'年级,
 --          cast(avg(height)as numeric(4,1))平均身高,
 --          cast(avg([weight])as numeric(4,1))平均体重,
 --          COUNT(case when (height < 91.1 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42) )
 --                       or (height < 90.2 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or (height < 95.0 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48) )
 --                       or (height < 94 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                     then userid else null end) 偏矮,
 --          COUNT(case when (height > 103.1 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or (height > 101.8 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or (height > 107.2 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                       or (height > 105.7 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                     then userid else null end) 偏高,
 --          COUNT(case when ([weight] < 13.0 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or ([weight] < 12.6 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or ([weight] < 13.9 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                       or ([weight] < 12.5 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                     then userid else null end) 偏瘦,
 --          COUNT(case when ([weight] > 17.6 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42) )
 --                       or ([weight] > 17.2 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 36 and 42)) 
 --                       or ([weight] > 18.7 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                       or ([weight] > 18.3 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 42 and 48))
 --                     then userid else null end) 偏胖
 --     from #t
 --     where grade = '小班'or ( grade is null and months between 36 and 48) 
      
 --  UNION ALL
   
 --       select '中班（4-5岁）'年级,
 --          cast(avg(height)as numeric(4,1))平均身高,
 --          cast(avg([weight])as numeric(4,1))平均体重,
 --          COUNT(case when (height < 98.7 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54) )
 --                       or (height < 97.6 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or (height < 102.1 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60)) 
 --                       or (height < 100.9 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60) )
 --                     then userid else null end) 偏矮,
 --          COUNT(case when (height > 111.0 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or (height > 109.3 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or (height > 114.5 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60) )
 --                       or (height > 112.8 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60) )
 --                     then userid else null end) 偏高,
 --          COUNT(case when ([weight] < 14.8 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or ([weight] < 14.3 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or ([weight] < 15.7 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60)) 
 --                       or ([weight] < 15.0 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60)) 
 --                     then userid else null end) 偏瘦,
 --          COUNT(case when ([weight] > 19.9 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or ([weight] > 19.4 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 48 and 54)) 
 --                       or ([weight] > 19.9 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60)) 
 --                       or ([weight] > 20.4 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 54 and 60)) 
 --                     then userid else null end) 偏胖
 --     from #t
 --     where grade = '中班' or ( grade is null and months between 48 and 60) 
      
 --   UNION ALL
   
 --       select '大班（5-6岁）'年级,
 --          cast(avg(height)as numeric(4,1))平均身高,
 --          cast(avg([weight])as numeric(4,1))平均体重,
 --          COUNT(case when (height < 105.3 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or (height < 104.0 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or (height < 108.4 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                       or (height < 106.9 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                     then userid else null end) 偏矮,
 --          COUNT(case when (height > 117.8 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or (height > 116.2 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or (height > 121 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                       or (height > 119.6 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                     then userid else null end) 偏高,
 --          COUNT(case when ([weight] < 16.6 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or ([weight] < 15.7 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or ([weight] < 17.4 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                       or ([weight] < 16.5 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                     then userid else null end) 偏瘦,
 --          COUNT(case when ([weight] > 22.3 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or ([weight] > 21.6 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 1)or months between 60 and 66) )
 --                       or ([weight] > 23.6 and gender = 3 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                       or ([weight] > 22.9 and gender = 2 and ((grade is not null and right(commonfun.dbo.fn_getCurrentTerm(0,getdate(),0),1)= 0)or months between 66 and 72) )
 --                     then userid else null end) 偏胖
 --     from #t
 --     where grade = '大班'or ( grade is null and months between 60 and 72) 
      
      
 -- if @mtype = 0
 -- select * from #result  
  
 --   if @mtype = 1
 -- select 年级,平均身高 from #result  
  
 --   if @mtype = 2
 -- select 年级,平均体重 from #result  
  
 --   if @mtype = 3
 -- select 年级,偏矮 from #result  
  
 --   if @mtype = 4
 -- select 年级,偏瘦 from #result  
  
 --   if @mtype = 5
 -- select 年级,偏高 from #result  
  
 --   if @mtype = 6
 -- select 年级,偏胖 from #result    
      
      
      
	--drop table #t,#result
	
	
	

                                                                                       
END 
GO
