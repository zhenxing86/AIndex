USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetListPage]    Script Date: 2014/11/24 23:13:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- =============================================
create PROCEDURE [dbo].[kweb_album_GetListPage]
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

SELECT albumid,t1.categoryid,t1.title,searchkey,searchdescription,photocount,cover,t1.orderno,t1.createdatetime ,t1.net 
FROM cms_album t1 
WHERE  categoryid=@categoryid	

END






GO
