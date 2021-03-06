USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_Exceptions_Get]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




create  procedure [dbo].[T_Exceptions_Get]
(
	@ExceptionType int = 0,
	@MinFrequency int = 10
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN

	SELECT TOP 100
		E.*
	FROM
		T_Exceptions E
	WHERE
		((@ExceptionType > 0 and E.Category = @ExceptionType ) or @ExceptionType <= 0 ) AND
		E.Frequency >= @MinFrequency
	ORDER BY
		E.Frequency DESC
END






GO
