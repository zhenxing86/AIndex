USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_content_content_relation_getCountByDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据时间获取文章数量
-- =============================================
CREATE PROCEDURE [dbo].[mh_content_content_relation_getCountByDateTime]
			@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20),
@categorycode nvarchar(20)
AS
BEGIN	
	DECLARE @count int
	
	if(@categorycode='shenqing')
	begin
	SELECT @count=COUNT(*)
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.categorycode = CASE @categorycode WHEN '' THEN p.categorycode ELSE @categorycode END
						AND p.status = 5 and c.deletetag = 1
						and c.title  LIKE '%'+@title+'%' 
						and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			) AS main_temp 
	end
	else
	begin
	SELECT @count=COUNT(*)
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.categorycode = CASE @categorycode WHEN '' THEN p.categorycode ELSE @categorycode END
						AND p.status = 1 and c.deletetag = 1  
						and c.title  LIKE '%'+@title+'%' 
						and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			) AS main_temp 
	end
	print @count
	RETURN @count
END
GO
