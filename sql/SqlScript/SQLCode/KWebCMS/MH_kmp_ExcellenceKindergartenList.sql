USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_ExcellenceKindergartenList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	ExcellenceKindergartenList
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_ExcellenceKindergartenList]
AS
BEGIN	
	select top 10 t2.id as kin_id, t2.url as kin_url, t2.name as kin_name,t2.actiondate as Kin_CreateDate,t2.kindesc as kin_desc, 'http://www.zgyey.com/Images/ModelImages/'+t2.theme+'.jpg' as kin_thumbpath, 
	(select accesscount from site where siteid = t2.id) as Kin_AccessCount
	from kmp..t_kindergarten t2  
	where t2.status = 1 and t2.ispublish = 1 and t2.privince=245 
	order by Kin_AccessCount desc
END




GO
