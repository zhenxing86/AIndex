USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_class_checked_sum_week_GetList]    Script Date: 2014/11/24 23:19:16 ******/
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
CREATE PROCEDURE [dbo].[rep_mc_class_checked_sum_week_GetList] 
	@kid int,
	@week varchar(10)
AS 
BEGIN 
	SET NOCOUNT ON
select	cname, SUM(totalcount), SUM(exceptionsum), sum(realcount),
				sum(notcome), SUM(parentstake), SUM(fs), SUM(hlfy), SUM(ks),
				SUM(lbt), SUM(fx), SUM(hy), SUM(szk), SUM(pz), SUM(fytx), SUM(jzj)
	from rep_mc_class_checked_sum 
	where kid = @kid 
		AND gid <> 38
	group by cid, cname, gorderby
	order by gorderby, cid
END

GO
