USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetClassListByUserID]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：按老师用户班级列表  
--项目名称：classhomepage  
--时间：-02-23 9:23:01  
------------------------------------  
CREATE  PROCEDURE [dbo].[class_GetClassListByUserID]   
@userid int  
 AS   
BEGIN  
  declare @kid int,@usertype int  
  select @kid=kid,@usertype=usertype from basicdata.dbo.[user] where userid=@userid  
  IF(dbo.IsManager(@userid,@kid)=1)  
  BEGIN  
    SELECT t1.cid,t1.kid,t1.cname,'' as theme, (select gname from basicdata..grade where gid=t1.grade) as gradetitle,grade  
    FROM basicdata..class t1  
    WHERE t1.kid=@kid and t1.deletetag=1 and t1.iscurrent=1 and t1.grade<>38  
    order by t1.grade,t1.[order]  
  END   
  else  
  begin  
   if(@usertype=0)  
   begin  
     if @kid = 0  
       SELECT t1.cid,t1.kid,t1.cname,'' as theme, (select gname from basicdata..grade where gid=t1.grade) as gradetitle,grade  
         From basicdata..class t1, BasicData.dbo.leave_user_class t2    
         WHERE t1.cid=t2.cid AND t2.userid = @userid and t1.deletetag = 1 and t1.iscurrent = 1   
         order by t1.grade,t1.[order]  
     else   
       SELECT t1.cid,t1.kid,t1.cname,'' as theme, (select gname from basicdata..grade where gid=t1.grade) as gradetitle,grade  
         FROM basicdata..class t1,basicdata..user_class t2    
         WHERE t1.cid=t2.cid AND t2.userid=@userid  and t1.deletetag=1 and t1.iscurrent=1   
         order by t1.grade,t1.[order]  
     
   end  
   else  
   begin  
     
     SELECT t1.cid,t1.kid,t1.cname,'' as theme, (select gname from basicdata..grade where gid=t1.grade) as gradetitle,grade  
     FROM basicdata..class t1,basicdata..user_class t2    
     WHERE t1.cid=t2.cid AND t2.userid=@userid  and t1.deletetag=1 and t1.iscurrent=1   
     and t1.grade<>38  
     order by t1.grade,t1.[order]  
        
    end   
      
  end  
END  
GO
