USE [ClassApp]
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-07  
-- Description: 取最近访客头像   
-- Memo:  

class_accessheadpic_GetList2 38436
class_accessheadpic_GetList 38436

*/  
alter PROCEDURE [dbo].[class_accessheadpic_GetList]  
 @classid int  
AS  
BEGIN  
 SET NOCOUNT ON  

declare @kid int =0
select @kid = c.kid from BlogApp..permissionsetting p
inner join basicdata..class c 
 on p.kid=c.kid and cid=@classid and deletetag=1 and p.ptype=91

if(@kid>0)
begin
	--关闭老师、家长博客(这种修改不彻底，1、只能限制班级主页的链接,2、其他幼儿园用户访问了班级主页，主人不能访问该访客的博客)
	declare @user table(userid int ,usertype int)
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
	insert into @user(userid,usertype)
	select userid,usertype from cet

	insert into @user(userid,usertype)
	select userid,0 from BasicData..[User_Child]
	where kid=@kid

	 SELECT top(9) u.nickname AS username, case when us.usertype>1 then ub.bloguserid else 0 end bloguserid,  
		 u.headpic,u.headpicupdate as headpicupdatetime,u.*   
	  FROM AppAccessLogs.dbo.class_accesslogs ca   
	   inner join BasicData.dbo.[user] u ON u.userid = ca.fromeuserid 
	   left join @user us on us.userid = u.userid 
	   LEFT JOIN BasicData.dbo.user_bloguser ub ON u.userid = ub.userid  
	  WHERE ca.classid = @classid and u.deletetag=1  
	   and u.usertype <> 98   
	  ORDER BY ca.accessdatetime desc  
  end
  else
  begin
	SELECT top(9) u.nickname AS username, ub.bloguserid,  
		 u.headpic,u.headpicupdate as headpicupdatetime    
	  FROM AppAccessLogs.dbo.class_accesslogs ca   
	   inner join BasicData.dbo.[user] u ON u.userid = ca.fromeuserid 
	   LEFT JOIN BasicData.dbo.user_bloguser ub ON u.userid = ub.userid  
	  WHERE ca.classid = @classid and u.deletetag=1  
	   and u.usertype <> 98   
	  ORDER BY ca.accessdatetime desc  
  end
END  


	  
