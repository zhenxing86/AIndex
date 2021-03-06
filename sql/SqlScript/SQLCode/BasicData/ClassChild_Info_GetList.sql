USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[ClassChild_Info_GetList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author: xie
DataTime: 2014-09-15
Desitipation:根据kid,老师/园长/管理员userid获取学生班级用户列表

[ClassChild_Info_GetList] 12511,718440  

*/
CREATE PROCEDURE [dbo].[ClassChild_Info_GetList]   
@kid int,  
@userid int=0  
as   
    if(CommonFun.dbo.[fn_KWebCMS_Right_max](@userid)<=2)  
    begin  
		select cid into #cids from BasicData..user_class where userid=@userid 
		 
		select grade gradeid,gname,c.cid,cname,COUNT(u.userid) childcount   
	   from BasicData..class c   
		inner join #cids s on s.cid=c.cid  
		inner join BasicData..grade g   
		 on c.grade=g.gid  
		inner join BasicData..user_class uc  
		 on uc.cid=c.cid  
		inner join BasicData..[user] u  
		 on uc.userid=u.userid   
		  and u.usertype=0    
		  and u.deletetag=1   
		  and u.kid=@kid  
		where c.kid=@kid  
		   and c.deletetag=1  
		group by grade,gname,c.cid,cname,g.[order],c.[order]  
		order by g.[order],c.[order] desc  
	    
	   select s.cid,u.userid,u.name username,u.mobile 
	   from #cids s 
		inner join BasicData..user_class uc  
		 on s.cid=uc.cid  
		inner join BasicData..[user] u  
		 on uc.userid=u.userid   
		  and u.usertype=0    
		  and u.deletetag=1   
		  and u.kid=@kid   
		order by s.cid,u.name desc  
		drop table #cids  
    end  
    else  
    begin  
      
	  select c.grade gradeid,gname,c.cid,cname,COUNT(u.userid) childcount  
	   from BasicData..class c   
		inner join BasicData..grade g   
		 on c.grade=g.gid  
		inner join BasicData..user_class uc  
		 on uc.cid=c.cid  
		inner join BasicData..[user] u  
		 on uc.userid=u.userid   
		  and u.usertype=0    
		  and u.deletetag=1   
		  and u.kid=@kid  
		where c.kid=@kid  
		   and c.deletetag=1  
		group by c.grade,gname,c.cid,cname,g.[order],c.[order]  
		order by g.[order],c.[order] desc  
      
       select uc.cid,u.userid,u.name username,u.mobile  
	   from BasicData..user_class uc  
		inner join BasicData..[user] u  
		 on uc.userid=u.userid   
		  and u.usertype=0    
		  and u.deletetag=1   
		  and u.kid=@kid   
		order by uc.cid,u.name desc  
    end  

GO
