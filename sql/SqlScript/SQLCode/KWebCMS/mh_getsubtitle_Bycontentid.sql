USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_getsubtitle_Bycontentid]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_sub_portaldoccontent_GetListByPage] 'mhjhzj',5,1,10
-- =============================================
create PROCEDURE [dbo].[mh_getsubtitle_Bycontentid]
@contentid int
AS
BEGIN
	select t1.subcategoryid,t1.subtitle from cms_subcategory t1,mh_subcontent_relation t2
	where t1.subcategoryid=t2.subcategoryid
	and t2.contentid=@contentid
END










GO
