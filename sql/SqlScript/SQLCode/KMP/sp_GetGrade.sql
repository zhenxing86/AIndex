USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGrade]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_GetGrade]
@KID int
AS
	SELECT DISTINCT t1.ClassGrade, t2.Caption
		FROM T_Class t1 INNER JOIN
     		 T_Dictionary t2 ON t1.ClassGrade = t2.ID
	WHERE (t1.Status = 1) AND (t1.KindergartenID = @KID) order by t1.classgrade
GO
