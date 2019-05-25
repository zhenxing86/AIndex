USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_homebook_week_Report]
AS

declare @hbid int
select top 1 @hbid= hbid from reportapp..homebook_log order by actiondate desc
--print @hbid
if(@hbid>0)
begin	
	exec reportapp..init_homebook_ByhomebookidV2 @hbid	
	delete reportapp..homebook_log where hbid=@hbid
end


GO
