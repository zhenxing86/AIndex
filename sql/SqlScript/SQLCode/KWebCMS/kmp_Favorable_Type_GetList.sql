USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Favorable_Type_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Favorable_Type_GetList]
@kid int
AS
BEGIN
	SELECT 
	Favorable_Type_ID,Favorable_Name,
	'KID'=(SELECT KID FROM zgyey_om..Kindergarten_Favorable WHERE Favorable_Type_ID=f.Favorable_Type_ID AND kid=@kid),
	'ActionDate'=(SELECT ActionDate FROM zgyey_om..Kindergarten_Favorable WHERE Favorable_Type_ID=f.Favorable_Type_ID AND kid=@kid),
	'Comments'=(SELECT Comments FROM zgyey_om..Kindergarten_Favorable WHERE Favorable_Type_ID=f.Favorable_Type_ID AND kid=@kid)
	FROM zgyey_om..Favorable_Type f
END





GO
