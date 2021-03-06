USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Documents_UpdateDocumentsInCategories]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     Proc [dbo].[doc_Documents_UpdateDocumentsInCategories]
(
	@CategoryList nvarchar(4000) = null,
	@RecordID varchar(16)
)
as

DELETE FROM doc_Document_InCategories where RecordID = @RecordID

-- 如果文档不属于任何分类,我们要重建索引
IF @CategoryList Is Not Null AND LEN(LTRIM(RTRIM(@CategoryList))) > 0
BEGIN
	DECLARE @idoc int
	-- declare @CategoryList nvarchar(4000)
	-- select @CategoryList = "<?xml version=""1.0"" ?><Categories><Category>Test</Category></Categories>"

	EXEC sp_xml_preparedocument @idoc OUTPUT, @CategoryList

	DECLARE @CategoryIDList TABLE
	(
		CategoryID Int
	)

/*
	--插入丢失的分类
	INSERT INTO doc_Categories ([Name], IsEnabled, ParentID, [Description] )
		Select 	
			C.[Category], 1, 0, null
		FROM 
			OPENXML(@idoc, '/Categories', 3)
				with (Category nvarchar(512) ) as C
		where 
			C.[Category] is not null  
			and C.[Category] not in (
				Select [Name] FROM doc_Categories
			) 
	IF @@ROWCOUNT < 0
		exec [doc_Categories_Parents_RebuildIndex]
*/
	Insert Into @CategoryIDList (CategoryID) 
	SELECT C.CategoryID 
		FROM OPENXML(@idoc, '/Categories/Category/', 2) X
		inner join doc_Categories C on Convert(nvarchar(16),C.[CategoryID]) = Convert(nvarchar(16),X.[text]) collate database_default

		INSERT INTO doc_Document_InCategories 
			( RecordID, CategoryID)
		Select 
			@RecordID, C.CategoryID
		FROM 
			@CategoryIDList C
	
	EXEC sp_xml_removedocument @idoc
END

-- 更新某分类下文档的数量
UPDATE doc_Categories SET
	TotalDocSubThreads = IsNull(QSUB.posts, 0),
	TotalDocThreads = IsNull(QCURR.posts, 0)
FROM doc_Categories 
LEFT  JOIN (
SELECT P.UplevelID CategoryID, COUNT(PIC.RecordID) posts 
FROM 
	doc_Document_InCategories PIC 
	INNER JOIN doc_Document jP ON (jP.RecordID = PIC.RecordID ) 
	INNER JOIN doc_Categories_Parents P ON PIC.CategoryID = P.CategoryID
	INNER JOIN doc_Categories C ON C.CategoryID = P.CategoryID
WHERE jP.IsEnabled = 1
GROUP BY P.UpLevelID
) QSUB ON doc_Categories.CategoryID = QSUB.CategoryID

LEFT  JOIN (
SELECT C.CategoryID CategoryID, COUNT(PIC.RecordID) posts 
FROM 
	doc_Document_InCategories PIC 
	INNER JOIN doc_Document jP ON (jP.RecordID = PIC.RecordID ) 
	INNER JOIN doc_Categories C ON C.CategoryID = PIC.CategoryID
WHERE jP.IsEnabled = 1
GROUP BY C.CategoryID
) QCURR ON doc_Categories.CategoryID = QCURR.CategoryID


GO
