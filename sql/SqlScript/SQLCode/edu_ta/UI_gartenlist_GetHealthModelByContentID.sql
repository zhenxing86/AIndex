USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetHealthModelByContentID]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UI_gartenlist_GetHealthModelByContentID]
@contentid int
 AS 

SELECT 
	0 ,t1.contentid,t1.title,t1.content, t1.createdatetime,t2.kname  	 
	from KWebCMS..cms_content t1 inner join
	[gartenlist] t2 on t1.siteid=t2.kid 
	and t1.categoryid =85972 where t1.contentid =@contentid and t1.deletetag = 1


GO
