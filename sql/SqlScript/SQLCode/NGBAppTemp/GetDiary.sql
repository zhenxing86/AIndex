USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetDiary]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 读取成长日记的详情 
-- Memo:use ngbapp  
exec GetDiary 1288560
*/  
--  
CREATE PROC [dbo].[GetDiary]
	@diaryid bigint
AS
BEGIN  
	SET NOCOUNT ON  
 SELECT gbid, d.pagetplid, d.diaryid, 
				CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, 
				d.CrtDate, pp.ckey, pp.cvalue, pp.ctype, ISNULL(d.Src,0)Src,pt.tpltype,pt.tplsubtype,d.share    
  FROM diary d   
   inner join page_public pp    
   on pp.diaryid = d.diaryid   
   inner join PageTpl pt
		on d.pagetplid = pt.pagetplid
  LEFT JOIN BasicData..[user] u    
   on u.userid = d.Author    
  where d.diaryid = @diaryid    

	DECLARE @CommentCnt int, @NiceCnt int 
	SELECT @CommentCnt = COUNT(1) 
		FROM Comment c 
		WHERE c.diaryid = @diaryid
	 
	SELECT @NiceCnt = COUNT(1) 
		FROM Nice n 
		WHERE n.diaryid = @diaryid
	SELECT CommentCnt = @CommentCnt, NiceCnt = @NiceCnt
	 
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取成长日志的详情' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiary', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
