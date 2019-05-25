USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[mobile_kwebcms_cms_content]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[mobile_kwebcms_cms_content]
@types int,--0通知新闻
@kid int
as
if(@types=0)
begin
select contentid,title,'',author,createdatetime from kwebcms..cms_content where categoryid = 17094 and status=1 and siteid=@kid and deletetag = 1
order by createdatetime desc
end

if(@types=1)
begin
select contentid,title,'',author,createdatetime from kwebcms..cms_content where categoryid = 17095 and status=1 and siteid=@kid and deletetag = 1
order by createdatetime desc
end

GO
