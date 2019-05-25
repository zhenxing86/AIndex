USE [edu_jy]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_GroupNoticeInformation_notice]    Script Date: 07/26/2013 14:58:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


alter PROCEDURE [dbo].[UI_GartenText_UpdateTop]
@contentid bigint,
@orderID int=0
AS 

 if(@OrderID>0)
 begin
	select @OrderID = Max([orderno])+1 from cms_content
 end
 
UPDATE cms_content
   SET [orderno] = @OrderID
 WHERE  contentid  =@contentid     
 
 update dbo.config_manage set syn=1 where appname ='历下前台'
GO
--UI_GartenText_GetListModel 2147483666
