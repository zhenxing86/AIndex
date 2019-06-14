USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDKinNotifys]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetGDKinNotifys
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDKinNotifys]
@size int
AS
BEGIN	
	SET ROWCOUNT @size
	select  kid as kin_id,name as kin_name,kurl as kin_url, kurl+'/'+convert(varchar(10),articleid)+'.html' as article_url, title as article_title, createdate as article_createdate 
	from kmp..v_KinNotifyList where privince=245 order by createdate desc
END



GO
