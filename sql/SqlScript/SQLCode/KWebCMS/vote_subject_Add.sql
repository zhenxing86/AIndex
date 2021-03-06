USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_subject_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vote_subject_Add]
@siteid int,
@title nvarchar(200)='',
@description nvarchar(100)='',
@votetype int,
@status int
AS
BEGIN

	declare @votesubjectid int
    INSERT INTO vote_subject([siteid],[title],[description],[votetype],[status],[createdatetime])
    VALUES(@siteid,@title,@description,@votetype,@status,GETDATE()) 
	set @votesubjectid=@@IDENTITY

	if(@votetype=1)
	begin
		INSERT INTO vote_item([votesubjectid],[title])
		VALUES(@votesubjectid,@title) 
	end
    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN @@IDENTITY
    END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_subject_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
