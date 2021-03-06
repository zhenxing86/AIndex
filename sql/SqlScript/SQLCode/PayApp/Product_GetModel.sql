USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[Product_GetModel]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- =============================================    
-- Author:  xie  
-- Create date: 2014-03-19    
-- Description: 获取产品信息
-- Memo:  
Product_GetModel 295765,1,2
*/    
Create PROCEDURE [dbo].[Product_GetModel]  
 @ftype int, --1：乐奇家园，2：数字图书
 @termtype int --1：小班上，2：小班下，3：中班上，4：中班下，5：大班上，6：大班下
AS    
BEGIN    
 SET NOCOUNT ON 
 
 select product_id,product_name,ftype,termtype,bean_count
  from product 
  where ftype=@ftype and termtype=@termtype  
  
END    


GO
