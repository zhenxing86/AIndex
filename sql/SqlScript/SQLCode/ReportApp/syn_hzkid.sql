USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[syn_hzkid]    Script Date: 2014/11/24 23:24:57 ******/
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
create   PROCEDURE [dbo].[syn_hzkid]

AS
BEGIN
exec init_rep_growthbook 11621
exec init_rep_growthbook 10290
exec init_rep_growthbook 16042
exec init_rep_growthbook 6232
exec init_rep_growthbook 5589
exec init_rep_growthbook 15461
exec init_rep_growthbook 5267
exec init_rep_growthbook 13535
exec init_rep_growthbook 12364
exec init_rep_growthbook 9947
exec init_rep_growthbook 9933
exec init_rep_growthbook 9932
exec init_rep_growthbook 9850
exec init_rep_growthbook 6396
exec init_rep_growthbook 5514
exec init_rep_growthbook 5440
exec init_rep_growthbook 12795
exec init_rep_growthbook 6735
exec init_rep_growthbook 6531
exec init_rep_growthbook 878
END
 


GO
