USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_weak_child_List]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_table_weak_child_List] 
@kid int
,@cid int
,@checktime1 datetime
,@checktime2 datetime
 AS 
BEGIN 
SET NOCOUNT ON 
select  rc.kid, rc.cid, rc.cname, rc.userid, rc.uname, zc.star3  
	from dbo.rep_mc_child_checked_detail rc 
		inner join zz_counter zc 
			on rc.userid = zc.userid
 where zc.kid = @kid 
	and (rc.cid = @cid or @cid=-1) 
	and rc.dotime between @checktime1 and @checktime2
	and zc.Isweak = 1 
	order by  zc.star3  DESC
END


GO
