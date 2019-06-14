USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag_ByTime]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
 AS 

SELECT 
	count(1),'',result,convert(varchar(10),intime,120) intime,0
	 FROM [remindlog] g 
where g.deletetag=1  and g.uid=@cuid 
and intime between @mtime1 and @mtime2
group by result,convert(varchar(10),intime,120)



GO
