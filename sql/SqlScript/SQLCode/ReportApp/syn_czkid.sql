USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[syn_czkid]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		liaoxin
-- Create date: 2011-6-29
-- Description:	获取指定幼儿园所以年级列表
--exec [BasicData_GetGradeListByKID] 58
-- =============================================
create   PROCEDURE [dbo].[syn_czkid]

AS
BEGIN
exec init_rep_growthbook 12355
exec init_rep_growthbook 12297
exec init_rep_growthbook 11529
exec init_rep_growthbook 10873
exec init_rep_growthbook 10871
exec init_rep_growthbook 10199
exec init_rep_growthbook 10141
exec init_rep_growthbook 10123
exec init_rep_growthbook 8969
exec init_rep_growthbook 8911
exec init_rep_growthbook 8797
exec init_rep_growthbook 14984
exec init_rep_growthbook 13614
exec init_rep_growthbook 8747
exec init_rep_growthbook 8676
exec init_rep_growthbook 13859
exec init_rep_growthbook 9803
exec init_rep_growthbook 9117
exec init_rep_growthbook 9018
exec init_rep_growthbook 13373
exec init_rep_growthbook 12732
exec init_rep_growthbook 12485
exec init_rep_growthbook 11820
exec init_rep_growthbook 11811
exec init_rep_growthbook 10716
exec init_rep_growthbook 10677
exec init_rep_growthbook 16228
END
 


GO
