USE [NGBApp]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-09-18
-- Description:	读取家园联系册的数据
-- Memo:
[GetHomeBookList] 46144,'2013-1' 
*/
ALTER PROC [dbo].[GetHomeBookList]  
 @cid int,  
 @term varchar(6)  
   
AS  
BEGIN  
 SET @term='2014-0'  
 SET NOCOUNT ON   
 select hb.hbid, hb.term, c.cname, hb.cid 
	from  HomeBook hb  
   left join BasicData..class c on hb.cid = c.cid  
  where hb.cid = @cid 
		and hb.term = @term  
   
   
END  