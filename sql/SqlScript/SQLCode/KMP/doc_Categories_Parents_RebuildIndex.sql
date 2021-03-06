USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Categories_Parents_RebuildIndex]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE     PROCEDURE [dbo].[doc_Categories_Parents_RebuildIndex]
AS
BEGIN

	SET NOCOUNT ON;

	--Create some temporary storage for the update
	DECLARE @pathtable TABLE(
		CategoryID int not null,
		UpLevelID int not null,
		[path] varchar(255),
		unique (CategoryID, UpLevelID))
	
	--修复孤立的分类
	UPDATE doc_Categories SET ParentID = 0 WHERE CategoryID IN (SELECT CategoryID FROM doc_Categories WHERE ParentID <> 0 AND ParentID NOT IN (SELECT CategoryID FROM doc_Categories))

	--每个分类的上一级至少是自己
	INSERT INTO @pathtable (CategoryID, UpLevelID, [path]) SELECT  CategoryID, CategoryID, '/' + Convert(varchar(10),CategoryID) + '/' FROM doc_Categories
	
	--获取所有上一级ID
	INSERT INTO @pathtable (CategoryID, UpLevelID, [path]) SELECT  CategoryID, ParentID, '/' + Convert(varchar(10),ParentID) + '/' + Convert(varchar(10),CategoryID) + '/' FROM doc_Categories WHERE ParentID > 0


	--递归所有情况
	WHILE @@Rowcount > 0
	BEGIN
		
		INSERT INTO @pathtable (CategoryID, UpLevelID, [path]) 

		SELECT  P.CategoryID, C.ParentID,  RIGHT('/' + Convert(varchar(10),C.ParentID) + P.[path], 255)
		FROM @pathtable P
			INNER JOIN doc_Categories C ON C.CategoryID = UpLevelID
			LEFT OUTER JOIN @pathtable DUPE ON P.CategoryID = DUPE.CategoryID AND C.ParentID = DUPE.UpLevelID
		WHERE ParentID > 0
			AND DUPE.UpLevelID IS NULL

	END	
/**
	--重新计算某分类下的文档数
	UPDATE doc_Categories SET
		TotalDocSubThreads = QSUB.records,
		TotalDocThreads = QCURR.records
	FROM doc_Categories 
	INNER JOIN (
	SELECT P.UplevelID CategoryID, COUNT(DIC.RecordID) records 
	FROM 
		doc_Document_InCategories DIC 
		INNER JOIN doc_Document D ON D.RecordID = DIC.RecordID 
		INNER JOIN @pathtable P ON DIC.CategoryID = P.CategoryID
		INNER JOIN doc_Categories C ON C.CategoryID = P.CategoryID

	GROUP BY P.UpLevelID
	) QSUB ON doc_Categories.CategoryID = QSUB.CategoryID

	INNER JOIN (
	SELECT C.CategoryID CategoryID, COUNT(DIC.RecordID) records
	FROM 
		doc_Document_InCategories DIC 
		INNER JOIN doc_Document D ON D.RecordID = DIC.RecordID 
		INNER JOIN doc_Categories C ON C.CategoryID = DIC.CategoryID
	GROUP BY C.CategoryID
	) QCURR ON doc_Categories.CategoryID = QCURR.CategoryID
**/
	--清空当前表
	TRUNCATE TABLE doc_Categories_Parents	

	--Commit the path table for use in adding / deleting posts in categories
	INSERT INTO doc_Categories_Parents (CategoryID, UpLevelID) SELECT CategoryID, UplevelID FROM @pathtable

	--Rebuild the path (for legacy support, this value is not currently used by the galleries)

	SELECT P.CategoryID, P.[Path] from @pathtable P JOIN doc_Categories C on P.UplevelID = C.CategoryID and C.ParentID = 0

	--Commit the new path to the Categoies table
	UPDATE doc_Categories SET doc_Categories.[Path] = NewPath.[path] from doc_Categories 
		JOIN 
			(SELECT P.CategoryID, P.[Path] FROM @pathtable P 
				JOIN doc_Categories C ON P.UplevelID = C.CategoryID AND C.ParentID = 0
			) NewPath ON doc_Categories.CategoryID = NewPath.CategoryID

END



GO
