USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_subject_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vote_subject_GetModel]
@votesubjectid int
AS
BEGIN
    SELECT [votesubjectid],[siteid],[title],[description],[votetype],[status],[createdatetime]
    FROM vote_subject
    WHERE votesubjectid=@votesubjectid
END



GO
