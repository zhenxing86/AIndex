USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_important_class_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rep_table_important_class_List]
@kid int,
@gid int,
@cid int,
@checktime1 datetime,
@checktime2 datetime

as



select kid,cid,cname,content,cdate,0,exceptionsum from dbo.rep_mc_class_checked_sum 
	where 
		 kid=@kid 
		and cdate between  @checktime1 and @checktime2
		and (gid=@gid or @gid=-1)
		and (cid=@cid or @cid=-1)
		and exceptionsum>0
		order by exceptionsum desc

		



GO
