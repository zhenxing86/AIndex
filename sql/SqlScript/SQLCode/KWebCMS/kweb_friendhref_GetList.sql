USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_friendhref_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-04
-- Description:	获取友情链接
-- =============================================
CREATE PROCEDURE [dbo].[kweb_friendhref_GetList]
@siteid int
AS
BEGIN
if(exists(select 1 from theme_kids where kid=@siteid) or not exists(select 1 from kin_friendhref where siteid=@siteid))
begin
	SET @siteid=11061
	--exec KWebCMS_Temp..[kweb_photo_GetIndex] @categorycode,14499,@page,@size
end
	SELECT id,caption,href FROM kin_friendhref 
	WHERE siteid=@siteid
	ORDER BY orderno DESC
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_friendhref_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
