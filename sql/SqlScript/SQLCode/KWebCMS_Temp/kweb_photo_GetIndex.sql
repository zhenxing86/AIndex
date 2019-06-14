USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetIndex]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[kweb_photo_GetIndex] 
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN

declare @categoryid int
if(@categorycode='hlsg')
begin
	set @categoryid=17104
end
else if(@categorycode='yezp')
begin
	set @categoryid=17106
end
	
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,commentcount,indexshow,
		flashshow,createdatetime,net,newid() FROM cms_photo		
		WHERE categoryid=@categoryid         
	
END









GO
