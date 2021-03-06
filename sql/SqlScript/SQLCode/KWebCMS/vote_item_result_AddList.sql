USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_result_AddList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[vote_item_result_AddList]
@voteitemid nvarchar(100),
@votefromip nvarchar(30)=''
AS
BEGIN

SET @voteitemid = CommonFun.dbo.FilterSQLInjection(@voteitemid)
SET @votefromip = CommonFun.dbo.FilterSQLInjection(@votefromip)
	DECLARE @sql nvarchar(4000)
	SET @sql='
	DECLARE @result int
	IF EXISTS
	(
	SELECT * FROM 
		(
		SELECT a.voteitemid,votedatetime,votefromip
		FROM vote_item a LEFT JOIN vote_item_result b ON a.voteitemid=b.voteitemid
		WHERE votesubjectid IN (SELECT votesubjectid FROM vote_item WHERE voteitemid IN ('+@voteitemid+'))
		) c
	WHERE votefromip='''+@votefromip+''' 
	AND DatePart(yy,GETDATE())=DatePart(yy,votedatetime) 
	AND DatePart(MM,GETDATE())=DatePart(MM,votedatetime) 
	AND DatePart(dd,GETDATE())=DatePart(dd,votedatetime)
	)
	BEGIN
		SET @result=-1
	END
	ELSE
	BEGIN
		INSERT INTO vote_item_result([voteitemid],[votedatetime],[votefromip])
		SELECT voteitemid,GETDATE(),'''+@votefromip+''' FROM vote_item WHERE voteitemid IN ('+@voteitemid+')

		IF @@ERROR <> 0
		BEGIN
			SET @result=0
		END
		ELSE
		BEGIN
			SET @result=1
		END
	END

	SELECT @result
	'
	
	EXEC (@sql)
END

GO
