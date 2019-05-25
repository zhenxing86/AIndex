use blogapp
go
 
blog_posts_GetModel 873163,1

select *from blog_baseconfig where userid=724650
select *from BasicData..user_bloguser where bloguserid=724650
select *from basicdata..[user] where userid =774637
  

  SELECT top 100 posttoclassdefault,commentpermission,openblogquestion,openbloganswer,kininfohide,messagepermission,postviewpermission,albumviewpermission  
 FROM blog_baseconfig  where openblogquestion!=''
 
 
 24071 广州金苗幼儿园   24072 广州金苗现代幼儿园  24073 新文化教育培训中心  这三家园的博客设置不要对外公开。谢谢！
 
 select u.account,*
 update bb set openblogquestion='访问密码是什么',openbloganswer='20150901'
 from blog_baseconfig bb
  inner join BasicData.dbo.user_bloguser ub 
   on bb.userid=ub.bloguserid
  inner join basicdata..[user] u 
   on ub.userid=u.userid and u.deletetag=1
   where u.kid =1940 --and bb.userid=820923
   and (bb.openblogquestion='' or bb.openblogquestion is null)
   




  
   
   
   select ub.bloguserid,u.name
   into #t
 from basicdata..[user] u
  left join BasicData.dbo.user_bloguser ub 
   on u.userid=ub.userid
  left join blog_baseconfig bb 
   on ub.bloguserid=bb.userid and u.deletetag=1
   where u.kid =21936 and u.usertype>0 and bb.userid is null
    insert into blog_baseconfig(userid,
blogtitle,description,defaultdispmode,postdispcount,themes,messagepref,postscount,albumcount,photocount,
visitscount,createdatetime,updatedatetime,lastposttitle,lastpostid,blogtype,blogurl,integral,iskmpuser,
kininfohide,isstart,posttoclassdefault,commentpermission,openblogquestion,openbloganswer,messagepermission,
postviewpermission,albumviewpermission,photowatermark)
select 
t.bloguserid,
t.name,
t.name +'个人描述',
defaultdispmode,
postdispcount,
themes,
messagepref,
postscount,
albumcount,
photocount,
visitscount,
createdatetime,
updatedatetime,
'我的博客开通了',
lastpostid,
blogtype,
'http://blog.zgyey.com/'+cast(bloguserid as varchar)+'/index.html',
integral,
iskmpuser,
kininfohide,
isstart,
posttoclassdefault,
commentpermission,
'',
'',
messagepermission,
postviewpermission,
albumviewpermission,
photowatermark
from blog_baseconfig b 
cross apply (select bloguserid,name from #t )t
where b.userid=98 

drop table #t
  
  
  
  
  
  
  