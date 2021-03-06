USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetTeacherInfoByCid]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- =============================================  
-- Author:  Master谭  
-- Create date: 2014-03-05  
-- Description: 根据cid查找老师信息  
-- Memo:   
*/  
CREATE PROCEDURE [dbo].[GetTeacherInfoByCid]   
 @cid int  
AS  
BEGIN  
 SET NOCOUNT ON;    
  select  u.name,t.title,u.mobile,u.headpic,u.headpicupdate  
   from BasicData..teacher t     
    inner join BasicData..[user] u     
     on t.userid = u.userid     
     and u.deletetag = 1     
    inner join BasicData..user_class uc    
     on uc.userid = u.userid    
   where uc.cid = @cid    
    and t.title in('主班老师','副班老师','保育员','医生')    
   order by case t.title when '主班老师' then 0 when '副班老师' then 1 when '保育员' then 2 when '医生' then 3 end     
   
END  
GO
