USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_List]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_growthbook_List]
@kid int
,@cid int
,@term varchar(20)
AS


select u.name,lifecount,workcount,videocount 
from dbo.rep_growthbook r
inner join BasicData..[user] u on u.userid=r.uid 
where r.kid=@kid and (r.cid=@cid or @cid=-1) and term=@term

GO
