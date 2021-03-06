USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Child_Categories_Get]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- exec doc_Child_Categories_Get 134,2


CREATE     PROCEDURE [dbo].[doc_Child_Categories_Get]
@CategoryID int,
@KID int = 0
AS

SET Transaction Isolation Level Read UNCOMMITTED

IF(@KID > 0)
Begin
	SELECT
		C.CategoryID
	FROM doc_Categories C,doc_Categories_Parents DCP where C.CategoryID = DCP.CategoryID and
	UpLevelID = @CategoryID and C.KID = @KID
	
End

ELSE
Begin
	SELECT
		CategoryID
	FROM doc_Categories_Parents DCP where UpLevelID = @CategoryID
End






GO
