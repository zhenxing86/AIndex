USE [NGBApp]
GO
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
		and h.term = @term  
   
   
END  
GO