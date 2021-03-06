USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_UserClass_GetUserClassName]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BasicData_UserClass_GetUserClassName]   
@userid int  
AS  
BEGIN  
  declare @usertype int, @kid int  
 select @usertype=usertype, @kid = kid from [user] where userid=@userid  
  
 if(@usertype=98)    
 begin  
  select '',0  
 end  
 else  
 begin  
   if @kid = 0  
   begin   
     if Exists (Select * From BasicData.dbo.leave_user_class a, BasicData.dbo.class b Where a.cid = b.cid and a.Userid = @userid)  
       Select top 1 b.cname, b.cid From BasicData.dbo.leave_user_class a, BasicData.dbo.class b Where a.cid = b.cid and a.Userid = @userid  
     else   
       Select '',0  
   end  
    else IF EXISTS(SELECT * FROM user_class WHERE userid=@userid)  
    BEGIN  
      SELECT top 1 t2.cname,t2.cid FROM  user_class t1 INNER JOIN class t2 on t1.cid=t2.cid WHERE t1.userid=@userid  
    END  
    ELSE  
    BEGIN  
     select  '',0  
    END  
 end  
END  
GO
