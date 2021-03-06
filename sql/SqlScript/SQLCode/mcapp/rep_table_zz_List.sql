USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_zz_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:    
-- Create date: 
-- Description:   
-- Memo:  
*/ 
CREATE PROCEDURE [dbo].[rep_table_zz_List]     
@kid int    
,@cid int    
,@checktime1 datetime    
,@zzid int    
 AS        
BEGIN        
 SET NOCOUNT ON    
  
 ;WITH CET AS    
 (    
  SELECT TOP 8    
     RIGHT(CONVERT(varchar(20),StartT,102),5) +'-'     
     +RIGHT( CONVERT(varchar(20),dateadd(dd,-1,EndT),102),5) weekdate,     
     StartT, EndT    
   FROM BasicData.dbo.WeekList     
   where StartT <= @checktime1    
   order by StartT desc    
 )      
 SELECT rm.kid, Cast(null as Int) cid, Cast(null as Varchar(50)) cname, rm.stuid userid, Cast(null as Varchar(50)) uname, rm.checkdate checktime,  
    rm.tw temperature, rm.zz + ',' result, c.weekdate, Cast(0 as bit) Isweak, Cast(null as Int) grade
 Into #result
 FROM CET c      
  left JOIN mcapp.dbo.stu_mc_day_zz rm on rm.checkdate > = c.StartT and rm.checkdate < c.EndT   
 WHERE rm.kid = @kid
  and ',' + zz + ',' like '%,' + convert(varchar,@zzid) + ',%'    
 
  Update a Set cid = b.cid, cname = b.cname, uname = b.name, grade = b.grade
    From #result a, BasicData..User_Child b
    Where a.userid = b.userid

  Delete #result Where grade In (38, 150) Or grade is null

  if @cid <> -1
    Delete #result Where cid <> @cid

  Update rm Set Isweak = zc.Isweak
    From #result rm,mcapp.dbo.zz_counter zc  
    Where rm.userid = zc.userid   

  Select * From #result order by checktime desc     
END  

GO
