USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Category_CreateUpdateDelete]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE  PROCEDURE [dbo].[doc_Category_CreateUpdateDelete]
	@Action int=0,
	@Name nvarchar(256)='',
	@IsEnabled bit=1,
	@ParentID int=0,
	@Description nvarchar(2000) = '',
	@CategoryID int=0 out,
	@KID int=0,
	@IsLock bit = 1,
	@AttachType int = 0,
	@ShowProperty nvarchar(50)='',
	@IsCommonMenu bit=0
AS
SET Transaction Isolation Level Read UNCOMMITTED
-- 删除分类
if @Action = 2
begin
	DELETE FROM doc_Document_InCategories WHERE CategoryID = @CategoryID
	DELETE FROM [doc_Categories_Parents] WHERE CategoryID = @CategoryID
	DELETE FROM T_Tree WHERE NodeID = @CategoryID
	DELETE FROM doc_Categories WHERE CategoryID = @CategoryID
	EXEC dbo.doc_Categories_Parents_RebuildIndex
	RETURN
end

-- 设置分类路径
declare @Path nvarchar(255)
set @Path = isnull((select Path + convert(nvarchar, CategoryID) + '/' from doc_Categories where CategoryID = @ParentID), '/')

-- 新增分类
if @Action = 0
begin
	if EXISTS(
		select * 
				from [dbo].[doc_Categories] 
				where (CategoryID = @CategoryID)
			)
	begin
		return
	end
	else
	begin
		INSERT INTO doc_Categories (CategoryID, Name, IsEnabled, ParentID, [Description], [Path], KID, IsLock, AttachType, ShowProperty,IsCommonMenu)
			VALUES (@CategoryID, @Name, @IsEnabled, @ParentID, @Description, @Path, @KID, @IsLock, @AttachType, @ShowProperty, @IsCommonMenu)
		set @CategoryID = SCOPE_IDENTITY()
	end
end

-- 更新分类
if @Action = 1 
begin
	if EXISTS(
		select * 
				from [dbo].[doc_Categories] 
				where (CategoryID = @CategoryID)
			)
	begin
		UPDATE doc_Categories SET
			Name = @Name,
			IsEnabled = @IsEnabled,
			ParentID = @ParentID,
			Description = @Description,
			Path = @Path,
			KID = @KID,
			IsLock = @IsLock,
			AttachType = @AttachType,
			ShowProperty = @ShowProperty,
			IsCommonMenu = @IsCommonMenu
		WHERE CategoryID = @CategoryID
	end
	else
	begin
		return 2
	end	
end

--EXEC dbo.doc_Categories_Parents_RebuildIndex






GO
