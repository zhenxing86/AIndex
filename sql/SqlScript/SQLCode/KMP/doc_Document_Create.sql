USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Document_Create]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE       PROCEDURE [dbo].[doc_Document_Create]
(
	@RecordID varchar(16),
	@Template varchar(16) = '',
	@IsEnabled bit = 1,
	@Subject varchar(254) = null,
	@Body ntext = null,
	@Description nvarchar(2000) = null,
	@Author varchar(64) = null,
	@Categories nvarchar(4000) = null,
	@FileName varchar(254) = null,
	@FileBody image = null,
	@FileType varchar(50) = null,
	@FileSize int,
	@FilePath varchar(128) = '',
	@HtmlPath varchar(128) = '',
	@UserHostAddress nvarchar(32),
	@ClassID int,
	@DateCreated datetime = null,
	@DocumentID int out,
	@LastModifyUser varchar(64) = null,
	@EditType varchar(50) = null,
	@IsPublish int,
	@DocType int,
	@DepartmentID int,
	@UserID int
) 
AS
SET NOCOUNT ON


--if(@Subject is not null)
--Begin

--	if exists(Select D.DocumentID FROM doc_Document D where D.Subject = @Subject)
--	Begin
--		Return 2
--	End
--End

-- set the PostDate
IF @DateCreated IS NULL
	SET @DateCreated = GetDate()

-- 默认文档是审核通过的.
SET NOCOUNT ON
BEGIN TRAN
	
	-- 添加一个新文档
	INSERT doc_Document 
		(
		RecordID, 
		Template, 
		IsEnabled, 
		Subject,
		Body,
		Description, 
		Author,
		FileName, 
		FileBody, 
		FileType,
		FileSize,
		FilePath,
		HtmlPath,
		IPAddress,
		ClassID,
		DateCreated,
		LastModifyUser,
		EditType,
		IsPublish,
		DocType,
		DepartmentID,
		UserID
	    )
	VALUES 
		( 
		@RecordID, 
		@Template, 
		@IsEnabled,
		@Subject, 
		@Body,
		@Description,
		@Author, 
		@FileName, 
		@FileBody, 
		@FileType,
		@FileSize,
		@FilePath,
		@HtmlPath,
		@UserHostAddress,
		@ClassID,
		@DateCreated,
		@LastModifyUser,
		@EditType,
		@IsPublish,
		@DocType,
		@DepartmentID,
		@UserID
		 )
		

	-- 获取文档ID
	SELECT 
		@DocumentID = @@IDENTITY
	
	-- 更新文档所属的分类
	exec doc_Documents_UpdateDocumentsInCategories @Categories, @RecordID
	
COMMIT TRAN

SET NOCOUNT OFF

SELECT @DocumentID = @DocumentID



GO
