USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[stu_mc_day_Setting]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-09-19
-- Description:	
-- Memo:	
	stu_mc_day_Setting 19449,0,'',5
*/
CREATE PROCEDURE [dbo].[stu_mc_day_Setting]
	@kid int,
	@str varchar(8000)= '',--'123,345'
	@userid int = 0
as  
BEGIN 
	SET NOCOUNT ON
  CREATE TABLE #ID(col int)
  
	INSERT INTO #ID
	select distinct col 	--将输入字符串转换为列表
			from BasicData.dbo.f_split(@str,',')
			
	update s 
		set ftype = 2
		from stu_mc_day s
			inner join #ID t 
				on t.col = s.[id] 
		where s.kid = @kid and ftype=1

	drop table #ID

END

GO
