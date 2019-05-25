USE [edu_jy]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_GroupNoticeInformation_notice]    Script Date: 07/26/2013 14:58:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


alter PROCEDURE [dbo].[UI_GartenText_Update]
@contentid bigint,
@title varchar(500),
@content varchar(max),
@ishow int,
@cuid int
AS 
 
 update cms_content set 
		title=@title,content=@content 
		where contentid=@contentid
 
 if(@ishow=1)
 begin
 
 delete ActicleState where contentid=@contentid
  
 end
 
  update dbo.config_manage set syn=1 where appname ='历下前台'
GO
--UI_GartenText_GetListModel 2147483666
