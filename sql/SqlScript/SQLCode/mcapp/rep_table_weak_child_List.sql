USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_weak_child_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  --rep_table_weak_child_List 12511,-1,'2014-10-10 00:00:00','2014-10-10 23:59:59'

CREATE PROCEDURE [dbo].[rep_table_weak_child_List]   
@kid int  
,@cid int  
,@checktime1 datetime  
,@checktime2 datetime  
 AS   
BEGIN   
SET NOCOUNT ON   
select  rc.kid, rc.cid, rc.cname, rc.userid, rc.uname, zc.star3,isnull(t.degree ,5)  
 from mcapp.dbo.rep_mc_child_checked_detail rc   
  inner join mcapp..zz_counter zc   
   on rc.userid = zc.userid  
  outer apply(
    select top 1 degree 
     from mcapp..rep_mc_child_week w 
     where zc.userid=w.userid and w.cdate>=dateadd(mm,-12, @checktime1)  --w.cdate between @checktime1 and @checktime2 
     order by  w.cdate desc
   )t
 where zc.kid = @kid   
 and (rc.cid = @cid or @cid=-1)   
 and rc.dotime between @checktime1 and @checktime2  
 and zc.Isweak = 1   
 order by  zc.star3  DESC  
END  
  
GO
