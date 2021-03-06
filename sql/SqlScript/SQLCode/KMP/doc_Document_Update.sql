USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Document_Update]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE        PROCEDURE [dbo].[doc_Document_Update]
(

	@RecordID varchar(16),
	@Template varchar(16),
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
	@FilePath varchar(128) = null,
	@HtmlPath varchar(128) = null,
	@Status varchar(4) = null,
	@TotalViews int,
	@UserHostAddress nvarchar(32),
	@Remark varchar(500) = null,
	@Admin ntext = null,
	@ClassID int,
	@DateCreated datetime,
	@LastModifyUser varchar(64) = null,
	@EditType varchar(50) = null,
	@IsPublish int,
	@DocType int,
	@DepartmentID int
)
AS


	
	UPDATE 
		doc_Document 
	SET
		Template = @Template,
		IsEnabled = @IsEnabled,
		Subject = @Subject,
		Body = @Body,
		Description = @Description,
		Author = @Author,
		FileName = @FileName,
		FileBody = @FileBody,
		FileType = @FileType,
		FileSize = @FileSize,
		FilePath = @FilePath,
		HtmlPath = @HtmlPath,
		Status = @Status,
		TotalViews = @TotalViews,
		IPAddress = @UserHostAddress,
		Remark = @Remark,
		Admin = @Admin,
		ClassID = @ClassID,
		DateCreated = @DateCreated,
		LastModifyUser = @LastModifyUser,
		EditType = @EditType,
		IsPublish = @IsPublish,
		DocType = @DocType,
		DepartmentID=@DepartmentID
	WHERE 
		RecordID = @RecordID


	-- 更新文档所属分类
	exec doc_Documents_UpdateDocumentsInCategories @Categories, @RecordID

GO
