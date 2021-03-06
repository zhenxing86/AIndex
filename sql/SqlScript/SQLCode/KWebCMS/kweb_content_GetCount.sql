USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	
-- Memo:	
declare @a int	
  EXEC @a = [kweb_content_GetCount] 'XW',5380
select @a
*/
CREATE PROCEDURE [dbo].[kweb_content_GetCount]
	@categorycode nvarchar(10),
	@siteid int
AS
BEGIN
	DECLARE @count int

if(@categorycode in('yebj','xw','gg') and @siteid=13336)
	begin
	SELECT @count=count(1) FROM cms_content  t1
	    INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
		WHERE t2.categorycode=@categorycode
			AND t1.[status]=1 and t1.deletetag = 1
			AND isnull(t1.draftstatus,0) = 0
			AND t1.siteid in (13336,13364,13362)		
	RETURN @count
	end
else if(@categorycode='gg' and (@siteid=13364 or @siteid=13362))
	begin
	SELECT @count=count(1) FROM cms_content  t1
	    INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
		WHERE 
			t2.categorycode='gg'
			AND t1.[status]=1 and t1.deletetag = 1
			AND isnull(t1.draftstatus,0) = 0
			AND (t1.siteid=@siteid or t1.siteid=13336)		
	RETURN @count
	end
else
begin 
	SELECT @count=count(1) FROM cms_content  t1
	    INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
		WHERE t2.categorycode=@categorycode
		AND t1.[status]=1 and t1.deletetag = 1
		AND isnull(t1.draftstatus,0) = 0
		AND t1.siteid=@siteid		
	RETURN @count
end
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
