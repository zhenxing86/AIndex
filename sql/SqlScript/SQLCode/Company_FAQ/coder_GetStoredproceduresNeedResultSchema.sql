USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[coder_GetStoredproceduresNeedResultSchema]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/24/2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[coder_GetStoredproceduresNeedResultSchema]
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
	where    sys.xtype = 'P' and sys.Name not like 'coder_%' and sys.Name not like 'sp_%'
			 and isnull(datediff(second,ver.LastUpdate,sys.refdate),
						1) > 0
	group by sys.name,ver.ReturnType,ver.ModelName,ver.MethodName,
			 ver.SelectIndex,ver.LastGenerate,ver.Version,ver.ShortTargetName,
			 ver.ParameterInfo,ver.ModelInfo,ver.LastUpdate,ver.IsTransaction
	order by sys.name

END








GO
