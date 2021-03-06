USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[coder_GetStoredprocedure]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/6/2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[coder_GetStoredprocedure]
	@StoredprocedureName VarChar(128)
AS
BEGIN
	SET NOCOUNT ON;

	select   sys.Name,
			 ver.ReturnType,
			 ver.ModelName,
			 ver.MethodName,
			 ver.SelectIndex,
			 ver.LastGenerate,
			 ver.Version,
			 ver.ShortTargetName,
			 ver.ParameterInfo,
			 ver.ModelInfo,
			 ver.LastUpdate,
			 count(col.Name) as ParameterNum,
			 ver.IsTransaction
	from     ((sysobjects sys
			   left join sys_GenerateVersion ver
				 on sys.Name = ver.Name
					and sys.xtype = ver.xtype)
			  left join syscolumns col
				on sys.id = col.id)
	where    sys.xtype = 'P'
			 and sys.Name = @StoredprocedureName
			 and isnull(datediff(second,ver.LastGenerate,sys.refdate),
						1) > 0
	group by sys.Name,ver.ReturnType,ver.ModelName,ver.MethodName,
			 ver.SelectIndex,ver.LastGenerate,ver.Version,ver.ShortTargetName,
			 ver.ParameterInfo,ver.ModelInfo,ver.LastUpdate, ver.IsTransaction
	order by sys.name

END
GO
