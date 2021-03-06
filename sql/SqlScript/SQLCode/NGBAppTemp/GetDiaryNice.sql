USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetDiaryNice]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 读取成长日记的赞详情 
-- Memo:use ngbapp  
exec GetDiaryNice 897168
*/  
--  
CREATE PROC [dbo].[GetDiaryNice]
	@diaryid bigint
AS
BEGIN  
	SET NOCOUNT ON  
	SELECT n.diaryid,u.name 
		FROM Nice n 
			inner join BasicData..[user] u 
			on n.userid = u.userid
			and n.diaryid = @diaryid
END	

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取成长日记的赞详情' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiaryNice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiaryNice', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
