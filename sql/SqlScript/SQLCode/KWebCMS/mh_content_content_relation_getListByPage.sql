USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_content_content_relation_getListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mh_content_content_relation_getListByPage]
	@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20),
@categorycode nvarchar(20),
@page int,
@size int
AS
BEGIN 
	SET NOCOUNT ON   
	DECLARE @beginRow INT
		DECLARE @endRow INT
		DECLARE @pcount INT
		SET @beginRow = (@page - 1) * @size    + 1
		SET @endRow = @page * @size		
	
	if(@categorycode='shenqing')
	begin
	
	IF(@page>1)  
	BEGIN 

		
		SELECT s_contentid, siteid, name, sitedns, title, author, actiondate,status,categorycode,createdatetime
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  ,p.status,p.categorycode,actiondate
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.status = 5 and c.deletetag = 1
						and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow 
	END  
	ELSE IF(@page=1)  
	BEGIN  
		SET ROWCOUNT @size  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, p.actiondate ,p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p   
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.status = 5 and c.deletetag = 1
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid desc  
	END  
	ELSE IF(@page=0)  
	BEGIN  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, p.actiondate, p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p  
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.status = 5 and c.deletetag = 1
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid DESC  
	END   
	
	end
	else
	begin
	if(LEN(@title)>0)
	begin
	IF(@page>1)  
	BEGIN     
		SELECT s_contentid, siteid, name, sitedns, title, author, actiondate,status,categorycode,createdatetime
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  ,p.status,p.categorycode,actiondate
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.categorycode = @categorycode
						AND p.status = 1 and c.deletetag = 1
						and c.title  LIKE '%'+@title+'%' 
						and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow 
	END  
	ELSE IF(@page=1)  
	BEGIN  
		SET ROWCOUNT @size  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime ,p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p   
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode
				AND p.status = 1 and c.deletetag = 1
				and c.title  LIKE '%'+@title+'%' 
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid desc  
	END  
	ELSE IF(@page=0)  
	BEGIN  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime ,p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p  
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode  
				AND p.status = 1 and c.deletetag = 1
				and c.title  LIKE '%'+@title+'%' 
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid DESC  
	END   
	end
	else
	begin
	IF(@page>1)  
	BEGIN     	

		SELECT s_contentid, siteid, name, sitedns, title, author, actiondate,status,categorycode,createdatetime
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  ,p.status,p.categorycode,actiondate
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.categorycode = @categorycode
						AND p.status = 1 and c.deletetag = 1
						and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow 
	END  
	ELSE IF(@page=1)  
	BEGIN  
		SET ROWCOUNT @size  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, p.actiondate ,p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p   
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode
				AND p.status = 1 and c.deletetag = 1
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid desc  
	END  
	ELSE IF(@page=0)  
	BEGIN  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, p.actiondate ,p.status,p.categorycode,c.createdatetime
			FROM	site s,
						cms_content c,
						mh_content_content_relation p  
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode
				AND p.status = 1 and c.deletetag = 1 
				and (p.actiondate BETWEEN  @startdatetime  AND  @enddatetime)
			ORDER BY c.contentid DESC  
	END   
	end
	end
	
END  

GO
