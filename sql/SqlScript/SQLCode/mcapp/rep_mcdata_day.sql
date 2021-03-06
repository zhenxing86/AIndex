USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_day]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：    
--项目名称：    
--时间：2014-8-4  
--作者：yz    
-- [dbo].[rep_mcdata_day] '2014-11-14','2014-11-14',19734  
------------------ ------------------    
    
CREATE PROCEDURE [dbo].[rep_mcdata_day]    
    
@bgndate date,    
@enddate date,    
@kid int  
    
AS     
BEGIN    
     
select *                        
  from mcapp..stu_mc_day
       
  where cdate >= CONVERT(VARCHAR(10),@bgndate,120)    
    and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)    
    and kid = @kid    
      
      
  order by adate desc,cdate desc 
    
end    
GO
