USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[GetCurTermType]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author: xie    
-- Create date:  2014-04-12   
-- Description:  根据userid获取该小朋友的当前学期   
-- Memo:   
   declare @curTermType int =-1 
   exec GetCurTermType 626908,@curTermType output  
   select @curTermType
   
   update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,6) 
from basicdata..[user] u where userid=626908
*/    
  
CREATE PROCEDURE [dbo].[GetCurTermType]  
@userid int,  
@curTermType int output  
as  
  
  set @curTermType = ossapp.dbo.GetCurTermType_fun(@userid)
  

   
GO
