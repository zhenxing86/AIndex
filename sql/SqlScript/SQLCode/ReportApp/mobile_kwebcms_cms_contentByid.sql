USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[mobile_kwebcms_cms_contentByid]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[mobile_kwebcms_cms_contentByid]
@contentid int,
@kid int
as

select contentid,title,[content],author,createdatetime from kwebcms..cms_content 
where contentid = @contentid and status=1  and siteid=@kid and deletetag = 1

GO
