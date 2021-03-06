USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[updateChildClassGetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
--批量调班获取幼儿列表 exec updateChildClassGetList 12511,0,'廖欣彦'  
CREATE proc [dbo].[updateChildClassGetList]  
@kid int,  
@cid int,  
@username nvarchar(200)   
as  
begin  
if(@cid =0)  
begin  
  if(len(@username)>0)  
 begin  
 select u.userid,u.account,u.name,u.mobile,u.gender,uc.cid,c.cname,c.grade from BasicData..[User] u   
 left join BasicData..user_class uc on u.userid=uc.userid  
 left join basicdata..class c on uc.cid=c.cid and c.kid=@kid and c.deletetag=1
 where u.kid=@kid and usertype=0 and u.deletetag=1  and u.name like '%'+@username+'%'  
 end  
 else  
 begin  
 select u.userid,u.account,u.name,u.mobile,u.gender,uc.cid,c.cname,c.grade from BasicData..[User] u   
 left join BasicData..user_class uc on u.userid=uc.userid  
 left join basicdata..class c on uc.cid=c.cid and c.kid=@kid and c.deletetag=1
 where u.kid=@kid and usertype=0 and u.deletetag=1   
 end  
end  
else  
begin  
 if(len(@username)>0)  
 begin  
  select u.userid,u.account,u.name,u.mobile,u.gender,uc.cid,c.cname,c.grade from BasicData..[User] u   
 left join BasicData..user_class uc on u.userid=uc.userid  
 left join basicdata..class c on uc.cid=c.cid and c.kid=@kid and c.deletetag=1
 where u.kid=@kid and usertype=0 and u.deletetag=1 and uc.cid=@cid and u.name like '%'+@username+'%'  
 end  
 else  
 begin  
  select u.userid,u.account,u.name,u.mobile,u.gender,uc.cid,c.cname,c.grade from BasicData..[User] u   
 left join BasicData..user_class uc on u.userid=uc.userid  
 left join basicdata..class c on uc.cid=c.cid and c.kid=@kid and c.deletetag=1
 where u.kid=@kid and usertype=0 and u.deletetag=1 and uc.cid=@cid 
 
   
 end  
end  
end
GO
