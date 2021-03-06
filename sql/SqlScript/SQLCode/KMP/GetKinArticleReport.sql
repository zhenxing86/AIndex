USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinArticleReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园文章统计报表>
-- =============================================
create PROCEDURE [dbo].[GetKinArticleReport] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select name, 
(select count(articleid) from articles where articlecategoryid in 
	(select articlecategoryid from articlecategory where typecode='GG' and kid = k.id)) as 公告,
(select count(articleid) from articles where articlecategoryid in 
	(select articlecategoryid from articlecategory where typecode='XW' and kid = k.id)) as 新闻
from t_kindergarten k order by 公告 desc
END
GO
