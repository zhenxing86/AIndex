USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenActivityByContentID]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenActivityByContentID]
	@contentid int
	
	 AS
	 
   select 1,title,content,createdatetime,viewcount from KWebCMS..cms_content 
   where contentid = @contentid
	

	RETURN 0





GO
