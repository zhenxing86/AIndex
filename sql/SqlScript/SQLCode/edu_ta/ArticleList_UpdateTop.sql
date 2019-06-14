USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_UpdateTop]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[ArticleList_UpdateTop]
  @ID int,  
  @OrderID int = 0                                   	
 AS 
 
 if(@OrderID>0)
 begin
	select @OrderID = Max([orderID])+1 from  dbo.ArticleList
 end
 
UPDATE [dbo].[ArticleList]
   SET [orderID] = @OrderID
     
 WHERE  id=@ID       
 
 select * from [ArticleList]  where id = 6215




GO
