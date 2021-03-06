USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[coder_SaveStoredProcedureWithResultSchemaInfo]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/9/2009
-- =============================================
CREATE PROCEDURE [dbo].[coder_SaveStoredProcedureWithResultSchemaInfo]
	@Name VarChar(128),
	@ReturnType VarChar(128),
	@SelectIndex Int,
	@ModelInfo VarChar(MAX)
AS
BEGIN
	SET NOCOUNT ON;

    if exists (select 1 from sys_GenerateVersion where [Name] =  @Name)
	begin
		update dbo.sys_GenerateVersion
			set ReturnType = @ReturnType,
				SelectIndex = @SelectIndex,
				ModelInfo = @ModelInfo,
				LastUpdate = getdate()
		where [Name] =  @Name
	end
	else
	begin
		insert into sys_GenerateVersion
			   ([Name]
			   ,ReturnType
			   ,MethodName
			   ,SelectIndex
			   ,Version
			   ,xtype
			   ,ShortTargetName
			   ,ModelInfo
			   ,LastUpdate)
		 values
			   (@Name, @ReturnType, '', @SelectIndex, 1, 'P', '', @ModelInfo, getdate())
	end

	if(@@error <> 0)
		return -1
	else
		return 1
END
GO
