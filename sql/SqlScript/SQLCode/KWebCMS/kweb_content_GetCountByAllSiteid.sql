USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetCountByAllSiteid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	
-- Memo:	
*/
CREATE PROCEDURE [dbo].[kweb_content_GetCountByAllSiteid]
	@categorycode nvarchar(10),
	@siteid varchar(50)
AS
BEGIN
    DECLARE @categorycode2 varchar(30)

    IF @categorycode<>'JGXX'
    BEGIN
      SET  @categorycode2=@categorycode
    END
    ELSE
    BEGIN
      SET @categorycode2='XW'
    END     
	DECLARE @newsiteid int
	SELECT top 1 @newsiteid=string FROM dbo.SpitString(@siteid ,',')
	DECLARE @count int
	SELECT @count = count(*) 
		FROM cms_content 
		WHERE categoryid in 
			(SELECT categoryid 
				FROM cms_category 
					WHERE (siteid = 0 or siteid = @newsiteid) 
						AND (categorycode = @categorycode or categorycode = @categorycode2) ) 
			AND status=1 and deletetag = 1
			AND isnull(draftstatus,0) = 0
			and siteid IN (SELECT string FROM dbo.SpitString(@siteid ,','))
			and orderno<>-1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetCountByAllSiteid', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetCountByAllSiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
