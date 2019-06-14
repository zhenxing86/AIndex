USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portaldoccontent_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_portaldoccontent_GetModel] 45810
-- =============================================
CREATE PROCEDURE [dbo].[mh_portaldoccontent_GetModel]
@contentid int
AS
BEGIN

select t1.*,t2.docid,t3.userid
from cms_content t1,mh_doc_content_relation t2,blogapp..thelp_documents t3
where t1.contentid=@contentid
and t1.contentid=t2.contentid
and t3.docid=t2.docid	and t1.deletetag = 1

END

GO
