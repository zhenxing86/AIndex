USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Get_DocumentSet]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec doc_Get_DocumentSet 1,20,'SET Transaction Isolation Level Read UNCOMMITTED Select  D.RecordID From dbo.doc_Document D  where D.DocumentID <> 0  and D.RecordID = 20060803111803  Order by D.DateCreated asc ',1,0,1,-1




CREATE        PROCEDURE [dbo].[doc_Get_DocumentSet]
(
	@PageIndex int, 
	@PageSize int,
	@sqlPopulate ntext,
	@IncludeCategories bit,
	@IncludePageIndex bit,
	@ReturnFullThread bit,
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
EXEC (@sqlPopulate)

SET @TotalRecords = @@rowcount


if @ReturnFullThread  = 1
	Begin
		SELECT 
			jPI.IndexID, P.*
		FROM 
			#PageIndex jPI 
			JOIN doc_Document P ON jPI.RecordID = P.RecordID
		ORDER BY
			jPI.IndexID

		IF @IncludeCategories = 1
		BEGIN
		
			SELECT 
				Cats.[Name] as CategoryName, jP.RecordID
			FROM 
				#PageIndex jPI
				JOIN doc_Document jP ON jPI.RecordID = jP.RecordID
				JOIN doc_Document_InCategories PIC ON jP.RecordID = PIC.RecordID
				JOIN doc_Categories Cats ON PIC.CategoryID = Cats.CategoryID
			
		End
	End
else
	Begin
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

		IF @IncludeCategories = 1
		BEGIN
		
			SELECT 
				Cats.[Name] as CategoryName, jP.RecordID
			FROM 
				#PageIndex jPI
				JOIN doc_Document jP ON jPI.RecordID = jP.RecordID
				JOIN doc_Document_InCategories PIC ON jP.RecordID = PIC.RecordID
				JOIN doc_Categories Cats ON PIC.CategoryID = Cats.CategoryID
			WHERE 
				jPI.IndexID > @PageLowerBound
				AND jPI.IndexID < @PageUpperBound
		
		
		End
	End




If @IncludePageIndex = 1
BEGIN
	SELECT IndexID, RecordID from #PageIndex ORDER BY IndexID
END

DROP TABLE #PageIndex

--select @TotalRecords











GO
