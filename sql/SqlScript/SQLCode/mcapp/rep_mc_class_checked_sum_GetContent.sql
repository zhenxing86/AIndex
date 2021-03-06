USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_class_checked_sum_GetContent]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-06-19  
-- Description:   
-- Memo:    
*/   
CREATE PROCEDURE [dbo].[rep_mc_class_checked_sum_GetContent]  
 @kid int,  
 @gid int,  
 @cid int,  
 @checktime1 datetime,  
 @checktime2 datetime  
as  
BEGIN  
 SET NOCOUNT ON   
   
 select cdate, cid, cname, content, 0   
  from dbo.rep_mc_class_checked_sum   
  where yd = 1   
   and kid = @kid  
   AND gid Not In (38, 150)
   and cdate between @checktime1 and @checktime2  
   and (gid = @gid or @gid = -1)  
   and (cid = @cid or @cid = -1)  
END  
GO
