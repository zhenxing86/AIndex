USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[PayExist]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- =============================================    
-- Author:  xie  
-- Create date: 2014-03-19    
-- Description: 判断购买权限
-- Memo:  
PayExist 295765,1,2,50,'乐奇家园(小班下学期)'  
*/    
Create PROCEDURE [dbo].[PayExist]  
 @userid int,  
 @ftype int, --1：乐奇家园，2：数字图书
 @termtype int --1：小班上，2：小班下，3：中班上，4：中班下，5：大班上，6：大班下
AS    
declare @ret int =0  
BEGIN    
 SET NOCOUNT ON   
  --乐奇家园
  if @ftype=1
  begin
	--@termtype 1：小班上，2：小班下，3：中班上，4：中班下，5：大班上，6：大班下
	select @ret = CommonFun.dbo.fn_RoleGet(lqRight,@termtype)
	  from BasicData..[user] 
	  where userid = @userid
  end
	
  select @ret  
   
    
END    


GO
