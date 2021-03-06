USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_result_GetStatResult]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-14
-- Description:	主观题统计结果
-- =============================================
CREATE PROCEDURE [dbo].[vote_item_result_GetStatResult]
@votesubjectid int
AS
BEGIN
	SELECT a.voteitemid,a.title,count(b.voteitemid) as counts
	FROM vote_item a LEFT JOIN vote_item_result b ON a.voteitemid=b.voteitemid
	WHERE votesubjectid=@votesubjectid
	GROUP BY a.voteitemid,a.title,b.voteitemid
END


GO
