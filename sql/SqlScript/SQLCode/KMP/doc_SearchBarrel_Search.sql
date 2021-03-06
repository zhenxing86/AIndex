USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_SearchBarrel_Search]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- SELECT DISTINCT [key],D.RecordID, Rank as Weight, D.DateCreated FROM doc_Document D, doc_Document_InCategories DIC, FreeTextTable (doc_Document,*,'主题') searchTable  WHERE D.RecordID = DIC.RecordID and [key] = D.DocumentID   ORDER BY  Weight DESC, DateCreated DESC




CREATE    procedure [dbo].[doc_SearchBarrel_Search] (
	@SearchSQL NText,
	--@RecordCountSQL nvarchar(4000),
	@PageIndex int = 0,
	@PageSize int = 25
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN

	DECLARE @StartTime datetime
	DECLARE @RowsToReturn int
	DECLARE @PageLowerBound int
	DECLARE @PageUpperBound int
	DECLARE @Count int
	DECLARE @TotalRecords int

	-- Used to calculate cost of query
	SET @StartTime = GetDate()

	-- Set the rowcount
	SET @RowsToReturn = @PageSize * (@PageIndex + 1)
	--SET ROWCOUNT @RowsToReturn

	-- Calculate the page bounds
	SET @PageLowerBound = @PageSize * @PageIndex
	SET @PageUpperBound = @PageLowerBound + @PageSize + 1

	-- Create a temp table to store the results in
	CREATE TABLE #SearchResults
	(
		IndexID int IDENTITY (1, 1) NOT NULL,
		RecordID varchar(16),
		Weight int,
		PostDate datetime,
		DocumentID int
	)

	-- Fill the temp table
	INSERT INTO #SearchResults (RecordID, Weight, PostDate, DocumentID)
	exec (@SearchSQL)

	SET @TotalRecords = @@rowcount

	SET ROWCOUNT @RowsToReturn

	-- SELECT actual search results from this table
	SELECT
		D.RecordID, D.Author, D.Subject, D.DateCreated,
		D.IPAddress, D.Description, D.Body, D.FileBody,
		D.ClassID, D.Template, D.DocumentID, D.FileType

	FROM 
		doc_Document D,
		#SearchResults R
	WHERE
		D.RecordID = R.RecordID AND
		R.IndexID > @PageLowerBound AND
		R.IndexID < @PageUpperBound
	Order By IndexID

	DROP Table #SearchResults

	Select @TotalRecords

	SELECT Duration = GetDate() - @StartTime
END








GO
