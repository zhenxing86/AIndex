USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_result_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[vote_item_result_Add]
@voteitemid int,
@votefromip nvarchar(30)=''
AS
BEGIN
--	IF EXISTS
--	(
--	SELECT * FROM 
--		(
--		SELECT a.voteitemid,votedatetime,votefromip
--		FROM vote_item a LEFT JOIN vote_item_result b ON a.voteitemid=b.voteitemid
--		WHERE votesubjectid IN (SELECT votesubjectid FROM vote_item WHERE voteitemid=@voteitemid)
--		) c
----	WHERE votefromip=@votefromip 
----	AND DatePart(yy,GETDATE())=DatePart(yy,votedatetime) 
----	AND DatePart(MM,GETDATE())=DatePart(MM,votedatetime) 
----	AND DatePart(dd,GETDATE())=DatePart(dd,votedatetime)
--	)
--	BEGIN
--		RETURN -1
--	END
--	ELSE
--	BEGIN
		INSERT INTO vote_item_result([voteitemid],[votedatetime],[votefromip])
		VALUES(@voteitemid,GETDATE(),@votefromip) 
--	END

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END





GO
