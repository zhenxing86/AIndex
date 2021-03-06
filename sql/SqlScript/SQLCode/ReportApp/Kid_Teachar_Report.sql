USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[Kid_Teachar_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Kid_Teachar_Report]
	@kid int,--幼儿园ID，当为0的时候发送所有幼儿园
	@firsttime datetime,
	@lasttime datetime,
	@order varchar(50),
	@page int,
	@size int
AS

set @order=CommonFun.dbo.FilterSQLInjection(@order)
create table #blogidlistTemp(userid int,bloguserid int,uname varchar(30))

create table #blogidlistorder
(userid int,bloguserid int,uname varchar(30),lsum int default 0,ptsum int default 0,csum int default 0,pssum int default 0,vsum int default 0)

insert into #blogidlistTemp(userid,bloguserid,uname)
select u.userid,b.bloguserid,u.[name]  
from BasicData..[user] u  --知道这个人是老师
inner join BasicData..user_bloguser b on b.userid=u.userid--知道这个人的bloguserid
where u.usertype=1 and u.kid=@kid and deletetag=1

--查询所有
if (@firsttime is null and @lasttime is null)  or (@firsttime = '' and @lasttime = '' )
begin

insert into #blogidlistorder(userid,bloguserid,uname,lsum,ptsum,csum,pssum,vsum)
select b.userid,bloguserid,uname,count(loginid) 登陆数,postscount 日志数,a.albumcount 相册数,photocount 相片数,visitscount 博客访问数 from #blogidlistTemp b
inner join blogapp..blog_baseconfig a on a.userid=b.bloguserid
left join applogs..log_login l on l.userid=b.userid
group by b.userid,bloguserid,uname,postscount,albumcount,photocount,visitscount

end
else 
begin
--当@firsttime或者@lasttime有数据的时候
--根据时间单个查询
--登录数和访问数
insert into #blogidlistorder(userid,bloguserid,uname,lsum,ptsum,csum,pssum,vsum)
select b.userid,bloguserid,uname,
(select sum(1) from applogs..log_login l where l.userid=b.userid and l.logindatetime between @firsttime and @lasttime) 登陆数,
(select count(1) from blogapp..blog_posts pt where pt.userid=b.bloguserid and pt.deletetag=1   and pt.postdatetime between @firsttime and @lasttime) 日志数,
(select count(1) from blogapp..album_categories c where c.userid=b.bloguserid  and c.deletetag=1   and c.createdatetime between @firsttime and @lasttime) 相册数,  
(select count(1) from blogapp..album_categories c left join blogapp..album_photos ps on ps.categoriesid=c.categoriesid and ps.deletetag=1 where c.userid=b.bloguserid  and c.deletetag=1  and ps.uploaddatetime between @firsttime and @lasttime) 相片数,  
(select a.visitscount from blogapp..blog_baseconfig a where  a.userid=b.bloguserid  ) 博客访问数
from #blogidlistTemp b

end

   exec sp_GridViewByPager  
    @viewName = '#blogidlistorder',             --表名  
    @fieldName = ' userid,bloguserid,uname ,lsum ,ptsum ,csum ,pssum ,vsum',      --查询字段  
    @keyName = 'userid',       --索引字段  
    @pageSize = @size,                 --每页记录数  
    @pageNo = @page,                     --当前页  
    @orderString = @order,          --排序条件  
    @whereString = ' 1 = 1 ' ,  --WHERE条件  
    @IsRecordTotal = 1,             --是否输出总记录条数  
    @IsRowNo = 0

drop table #blogidlistorder
drop table #blogidlistTemp

GO
