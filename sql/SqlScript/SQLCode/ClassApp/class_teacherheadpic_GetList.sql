/*------------------------------------    
--用途：取班级老师头像    
--项目名称：ClassHomePage    
--说明：    
--时间：2009-02-05 10:28:31    

exec [class_teacherheadpic_GetList] 38436  

------------------------------------ */   
alter PROCEDURE [dbo].[class_teacherheadpic_GetList]     
 @classid int    
AS    

declare @kid int =0
select @kid = c.kid from BlogApp..permissionsetting p
inner join basicdata..class c 
 on p.kid=c.kid and cid=@classid and deletetag=1 and p.ptype=91

if(@kid>0)
begin
	--关闭老师、家长博客  (这种修改不彻底，1、只能限制班级主页的链接)
	;with cet as
	(
		select su.appuserid userid,max(CASE l.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1  end) usertype 
		 from KWebCMS..site_user su  
		  inner join BasicData..[user] us on us.userid =su.appuserid and us.deletetag=1 and us.usertype>0
		  inner join basicdata..class c on su.siteid=c.kid and c.kid=@kid
		  inner join KWebCMS_Right.dbo.sac_user u on u.user_id = su.UID  
		  inner join KWebCMS_Right.dbo.sac_user_role r on r.user_id = u.user_id  
		  inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id  
		 group by su.appuserid 
	)
	SELECT u.name AS username, ub.bloguserid,u.headpic,u.headpicupdate as headpicupdatetime,t.title    
	  FROM  BasicData.dbo.user_bloguser ub     
	   INNER JOIN BasicData.dbo.[user] u on ub.userid = u.userid    
	   inner join BasicData.dbo.user_class uc on u.userid = uc.userid  
	   inner join cet c on c.userid = u.userid   
	   RIGHT JOIN BasicData.dbo.teacher t ON t.userid = ub.userid    
	  WHERE u.deletetag = 1     
	  AND u.usertype <> 98     
	  and u.usertype>0  
	  AND uc.cid = @classid    
	  order by t.title desc
  
end
else
begin
	SELECT u.name AS username, ub.bloguserid,u.headpic,u.headpicupdate as headpicupdatetime,t.title    
	  FROM  BasicData.dbo.user_bloguser ub     
	   INNER JOIN BasicData.dbo.[user] u on ub.userid = u.userid    
	   inner join BasicData.dbo.user_class uc on u.userid = uc.userid    
	   RIGHT JOIN BasicData.dbo.teacher t ON t.userid = ub.userid    
	  WHERE u.deletetag = 1     
	  AND u.usertype <> 98     
	  and u.usertype>0  
	  AND uc.cid = @classid    
	  order by t.title desc
end


 