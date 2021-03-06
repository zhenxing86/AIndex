USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_recent_week_dataup]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-6-20
-- Description:	最近一周没有上传数据的幼儿园
--[dbo].[mm_recent_week_dataup] 1,100
-- =============================================
CREATE PROCEDURE [dbo].[mm_recent_week_dataup]
 @page int,        
 @size int

AS
BEGIN
	SET NOCOUNT ON;
  
 select distinct kid 
   into #p
   from mcapp..stu_mc_day_raw 
  where cdate >= CONVERT(VARCHAR(10),DATEADD(DD,-7,GETDATE()),120)

select distinct k.kid,k.kname,u.name,i.finfofrom
  into #t
  from BasicData..kindergarten k
  left join BlogApp..permissionsetting p
      on k.kid = p.kid
  left join ossapp..kinbaseinfo i
      on k.kid = i.kid
  left join ossapp..[Users] u
      on i.developer = u.id
 
    
    
  where k.kid in (select distinct kid                                                                                                                                                                                                                                                                                      
                  from mcapp..driveinfo)
    and k.kid not in (select distinct kid from #p where kid is not null)
    and k.kid not in (12511,11061,22018,22030,22053,21935,22084)
    and p.ptype = 90
                         
   --分页查询                    
 exec sp_MutiGridViewByPager                    
  @fromstring = '#t ',      --数据集                    
  @selectstring =                     
  'kid,kname,name,finfofrom',      --查询字段                    
  @returnstring =                     
  'kid,kname,name,finfofrom',      --返回字段                    
  @pageSize = @Size,                 --每页记录数                    
  @pageNo = @page,                     --当前页                    
  @orderString = 'name,kid',          --排序条件                    
  @IsRecordTotal = 1,             --是否输出总记录条数                    
  @IsRowNo = 0          --是否输出行号          
    
drop table #t,#p
        
   
END

GO
