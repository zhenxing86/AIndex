USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[coder_SaveStoredProcedureVersion]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 3/5/2009
-- =============================================
CREATE PROCEDURE [dbo].[coder_SaveStoredProcedureVersion]
	@Name VarChar(128),
	@ReturnType VarChar(128),
	@ModelName VarChar(128),
	@MethodName VarChar(128),
	@ShortTargetName VarChar(128),
	@ParameterInfo VarChar(128),
	@IsTransaction Bit
AS
BEGIN
	SET NOCOUNT ON;

    if exists (select 1 from sys_GenerateVersion where [Name] =  @Name)
	begin
		update dbo.sys_GenerateVersion
			set ReturnType = @ReturnType,
				ModelName = @ModelName,
				MethodName = @MethodName,
				LastGenerate = GetDate(),
				Version = Version + 1,
				ShortTargetName = @ShortTargetName,
				ParameterInfo = @ParameterInfo,
				IsTransaction = @IsTransaction
		where [Name] =  @Name
	end
	else
	begin
		insert into sys_GenerateVersion
			   (Name, ReturnType, ModelName, MethodName, SelectIndex, LastGenerate, Version, xtype, ShortTargetName, ParameterInfo, LastUpdate, IsTransaction)
		 values
			   (@Name, @ReturnType, @ModelName, @MethodName, 0, GetDate(), 1, 'P', @ShortTargetName, @ParameterInfo, GetDate(), @IsTransaction)
	end

	if(@@error <> 0)
		return -1
	else
		return 1
END



GO
