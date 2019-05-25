USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[classdatamove]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[classdatamove]

CREATE PROCEDURE [dbo].[classdatamove]
@fromcid int,
@targetcid int
 AS

	update class_notice set classid=@targetcid where classid=@fromcid

	update class_notice_class set classid=@targetcid where classid=@fromcid

	update class_album set classid=@targetcid where classid=@fromcid

	update class_schedule set classid=@targetcid where classid=@fromcid

	update class_video set classid=@targetcid where classid=@fromcid

	update class_backgroundmusic set classid=@targetcid where classid=@fromcid


GO
