USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_remind_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_remind_list]
@ftime datetime
,@ltime datetime
,@uid int
 AS 

select types ,ontime ,uid ,info 
from dbo.remindlog l
left join dbo.remindmange r on r.ID=l.rid



GO
