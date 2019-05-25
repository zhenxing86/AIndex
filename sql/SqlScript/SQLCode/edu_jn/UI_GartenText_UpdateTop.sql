USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_GartenText_UpdateTop]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[UI_GartenText_UpdateTop]
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
