USE [edu_jy]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_GroupNoticeInformation_notice]    Script Date: 07/26/2013 14:58:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


alter PROCEDURE [dbo].[UI_GartenText_GetListModel]
@contentid bigint
 AS 
 
 
 select c.contentid,title,content,createdatetime,author,a.ishow,viewcount
 from cms_content c
  left join ActicleState a on a.contentid=c.contentid   
 where c.contentid=@contentid 
 --and a.ishow is null
 


GO
UI_GartenText_GetListModel 2147483666
