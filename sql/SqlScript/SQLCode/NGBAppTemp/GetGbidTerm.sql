USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetGbidTerm]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 读取成长档案的学期信息 
-- Memo:use ngbapp  
exec GetGbidTerm 653612
*/  
--  
CREATE PROC [dbo].[GetGbidTerm]
	@userid bigint
AS
BEGIN  
	SET NOCOUNT ON 
	select gb.gbid, g.gname + CASE WHEN RIGHT(gb.term,1) = '1' then '上学期' ELSE '下学期' END term
		from growthbook gb 
			inner join BasicData..grade g 
				on gb.grade = g.gid 
		where gb.userid = @userid
	ORDER BY gb.term DESC

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取成长档案的学期信息 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGbidTerm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGbidTerm', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
