USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[sb_book_detail_GetList]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[sb_book_detail_GetList]
AS 
	select sbid,sbtitle,sbcontent,video_url,pdate from dbo.sb_book_detail

GO
