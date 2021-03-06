USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowthBookList]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-09-18
-- Description:	读取growthbook的数据
-- Memo:
[GetGrowthBookList] 295765,'2013-1' 
*/
--
CREATE PROC [dbo].[GetGrowthBookList]
	@userid int,
	@term varchar(6)
	
AS
BEGIN
	SET @term='2014-0'
	SET NOCOUNT ON	
	select gbid,term,c.cname,'0' as candownload from  growthbook g
			left join BasicData..user_class uc on g.userid=uc.userid
			left join BasicData..class c on uc.cid=c.cid
		where g.userid=@userid --and g.term=@term
	
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取growthbook的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookList', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookList', @level2type=N'PARAMETER',@level2name=N'@term'
GO
