USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_detail_child_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rep_table_detail_child_List] 
 @kid int
,@userid int
,@checktime1 datetime
,@checktime2 datetime
 AS 
 
 declare @result varchar(2000)
 set @result=''
 
 select @result=@result+result
 from dbo.rep_mc_child_checked_detail
 where kid=@kid and userid=@userid  
 and dotime between @checktime1 and @checktime2
 
 select kid,cname,userid,uname,@result
 ,sum(case when result like '%11,%'  then 0 else 1 end) parentstake
 ,sum(case when checktime is not null then 0 else 1 end) notcome
  from dbo.rep_mc_child_checked_detail
 where kid=@kid and userid=@userid  
 and dotime between @checktime1 and @checktime2
 group by kid,cname,userid,uname
 


GO
