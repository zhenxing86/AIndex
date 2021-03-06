USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_Exceptions_Log]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




create procedure [dbo].[T_Exceptions_Log]
(
	@ExceptionHash varchar(128),
	@Category int,
	@Exception nvarchar(2000),
	@ExceptionMessage nvarchar(500),
	@UserAgent nvarchar(64),
	@IPAddress varchar(15),
	@HttpReferrer nvarchar (256),
	@HttpVerb nvarchar(24),
	@PathAndQuery nvarchar(512)
)
AS
BEGIN

SET Transaction Isolation Level Read UNCOMMITTED

IF EXISTS (SELECT ExceptionID FROM T_Exceptions WHERE ExceptionHash = @ExceptionHash)

	UPDATE
		T_Exceptions
	SET
		DateLastOccurred = GetDate(),
		Frequency = Frequency + 1
	WHERE
		ExceptionHash = @ExceptionHash
ELSE
	INSERT INTO 
		T_Exceptions
	(
		ExceptionHash,
		Category,
		Exception,
		ExceptionMessage,
		UserAgent,
		IPAddress,
		HttpReferrer,
		HttpVerb,
		PathAndQuery,
		DateCreated,
		DateLastOccurred,
		Frequency
	)
	VALUES
	(
		@ExceptionHash,
		@Category,
		@Exception,
		@ExceptionMessage,
		@UserAgent,
		@IPAddress,
		@HttpReferrer,
		@HttpVerb,
		@PathAndQuery,
		GetDate(),
		GetDate(),
		1
	)

END














GO
