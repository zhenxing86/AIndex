USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_GartenText_GetListModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UI_GartenText_GetListModel]
@contentid bigint
 AS 
 
 
 select c.contentid,title,content,createdatetime,author,a.ishow,viewcount
 from cms_content c
  left join ActicleState a on a.contentid=c.contentid   
 where c.contentid=@contentid 
 --and a.ishow is null
 



GO
