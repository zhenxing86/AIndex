USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBookListByUserid]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      along  
-- Create date: 2013-09-18  
-- Description: 读取家园联系册的数据  
-- Memo:  
[GetHomeBookList] 46144,'2013-1'   
*/  
--  
CREATE PROC [dbo].[GetHomeBookListByUserid]  
 @uid int,  
 @term varchar(6)     
AS  
BEGIN    
 SET @term='2014-0'     
 SET NOCOUNT ON   
 select h.hbid, h.term, c.cname, h.cid 
	from  HomeBook h  
   left join BasicData..class c on h.cid = c.cid  
   left join basicdata..user_class uc on c.cid = uc.cid  
  where uc.userid = @uid 
		--and h.term = @term  
   order by h.CrtDate desc
   
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取家园联系册的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetHomeBookListByUserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetHomeBookListByUserid', @level2type=N'PARAMETER',@level2name=N'@uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetHomeBookListByUserid', @level2type=N'PARAMETER',@level2name=N'@term'
GO
