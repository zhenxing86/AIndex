USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_thelp_documents_GetCountByDateTime]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_thelp_documents_GetCountByDateTime]
@startdate datetime,
@enddate datetime,
@title nvarchar(30),
@content nvarchar(30)
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blogapp..thelp_documents  
	WHERE publishdisplay=1 AND aprove=0 AND createdatetime BETWEEN @startdate AND @enddate		
		AND (title LIKE '%'+@title+'%')
		AND docid not in (select docid from mh_doc_content_relation)
	RETURN @TempID	
GO
