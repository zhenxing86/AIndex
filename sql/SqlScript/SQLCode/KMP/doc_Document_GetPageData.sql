USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Document_GetPageData]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- exec doc_Document_GetPageData 1,20



create         PROCEDURE [dbo].[doc_Document_GetPageData]
(
	@PageIndex int, 
	@PageSize int,
	@TotalRecords int output
)
AS
SET Transaction Isolation Level Read UNCOMMITTED

DECLARE @PageLowerBound int
DECLARE @PageUpperBound int
DECLARE @RowsToReturn int
DECLARE @TotalThreads int

-- First set the rowcount
SET @RowsToReturn = @PageSize * (@PageIndex + 1)


-- Set the page bounds
SET @PageLowerBound = @PageSize * @PageIndex
SET @PageUpperBound = @PageLowerBound + @PageSize + 1



-- Create a temp table to store the select results
CREATE TABLE #PageIndex 
(
	IndexID int IDENTITY (1, 1) NOT NULL,
	RecordID varchar(16)
)

--CREATE INDEX page_index ON #PageIndex(IndexID)

INSERT INTO #PageIndex (RecordID)
select RecordID from doc_Document

SET @TotalRecords = @@rowcount

SET ROWCOUNT @RowsToReturn
SELECT 
	jPI.IndexID, P.*
FROM 
	#PageIndex jPI 
	JOIN doc_Document P ON jPI.RecordID = P.RecordID
WHERE 
	jPI.IndexID > @PageLowerBound
	AND jPI.IndexID < @PageUpperBound
ORDER BY
	jPI.IndexID	
SET ROWCOUNT 0







DROP TABLE #PageIndex

--select @TotalRecords












GO
