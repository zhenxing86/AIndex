USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[Kid_Child_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Kid_Child_Report] 1940,'2001-1-1','2012-12-12','uname desc ',1,11,-1
--[Kid_Child_Report] 58,'','','uname desc',1,11,-1
CREATE PROCEDURE [dbo].[Kid_Child_Report]
	@kid int,--幼儿园ID，当为0的时候发送所有幼儿园
	@firsttime datetime,
	@lasttime datetime,
	@order varchar(50),
	@page int,
	@size int,
	@classid int--班级ID：-1全部班级
AS

set @order = CommonFun.dbo.FilterSQLInjection(@order)

create table #blogidlistTemp
(
userid int
,bloguserid int
,uname varchar(50)
)

create table #blogidlistorder
(
userid int
,bloguserid int
,uname varchar(50)
,lsum int default 0
,ptsum int default 0
,csum int default 0
,pssum int default 0
,vsum int default 0
)

IF @classid = -1
insert into #blogidlistTemp(userid,bloguserid,uname)
	select u.userid,b.bloguserid,u.name 
		from BasicData..[User_Child] u  
			inner join BasicData..user_bloguser b 
				on b.userid = u.userid
		where u.kid = @kid 
ELSE 
insert into #blogidlistTemp(userid,bloguserid,uname)
	select u.userid,b.bloguserid,u.name 
		from BasicData..[User_Child] u  
			inner join BasicData..user_bloguser b 
				on b.userid = u.userid
		where u.kid = @kid and u.cid = @classid

--查询所有
if (@firsttime is null and @lasttime is null)  or (@firsttime = '' and @lasttime = '' )
begin

	insert into #blogidlistorder(userid,bloguserid,uname,lsum,ptsum,csum,pssum,vsum)
	select b.userid,bloguserid,uname,count(loginid) 登陆数,postscount 日志数,a.albumcount 相册数,photocount 相片数,visitscount 博客访问数 
	from #blogidlistTemp b
	inner join blogapp..blog_baseconfig a on a.userid=b.bloguserid
	left join applogs..log_login l on l.userid=b.userid
	group by b.userid,bloguserid,uname,postscount,albumcount,photocount,visitscount

end
else 
begin
--当@firsttime或者@lasttime有数据的时候
--根据时间单个查询
--登录数和访问数
--
if (@page>1 )
begin
insert into #blogidlistorder(userid,bloguserid,uname,lsum,ptsum,csum,pssum,vsum)
select b.userid,bloguserid,uname,
(select sum(1) from applogs..log_login l where l.userid=b.userid and l.logindatetime between @firsttime and @lasttime) 登陆数,
(select count(1) from blogapp..blog_posts pt where pt.userid=b.bloguserid and pt.deletetag=1   and pt.postdatetime between @firsttime and @lasttime) 日志数,
(select count(1) from blogapp..album_categories c where c.userid=b.bloguserid  and c.deletetag=1   and c.createdatetime between @firsttime and @lasttime) 相册数,  
(select count(1) from blogapp..album_categories c left join blogapp..album_photos ps on ps.categoriesid=c.categoriesid and ps.deletetag=1 
where c.userid=b.bloguserid  and c.deletetag=1  and ps.uploaddatetime between @firsttime and @lasttime) 相片数,  
(select a.visitscount from blogapp..blog_baseconfig a where  a.userid=b.bloguserid  ) 博客访问数
from #blogidlistTemp b

end
end

declare @pcount int
select @pcount=count(1) from #blogidlistTemp

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			 exec('SELECT userid FROM #blogidlistorder  order by '+@order) 

			SET ROWCOUNT @size
			SELECT 
				@pcount,userid,bloguserid,uname 姓名,lsum 登陆数,ptsum 日志数,csum 相册数,pssum 相片数,vsum 博客访问数 
			FROM 
				@tmptable AS tmptable		
			INNER JOIN #blogidlistorder t1
			ON  tmptable.tmptableid=t1.userid 	
			WHERE
				row>@ignore

end
else
begin
SET ROWCOUNT @size
DECLARE @f varchar(10), @l varchar(10),@s varchar(max)
set @f = CONVERT(VARCHAR(10),@firsttime,120)
set @l = CONVERT(VARCHAR(10),DATEADD(dd,1,@lasttime),120)

set @s = 'select '+CAST(@pcount AS VARCHAR(10))+',b.userid,bloguserid,uname ,
(select sum(1) from applogs..log_login l where l.userid=b.userid and l.logindatetime between '''+@f+''' and '''+@l+''') lsum,
(select count(1) from blogapp..blog_posts pt where pt.userid=b.bloguserid and pt.deletetag=1   and pt.postdatetime between '''+@f+''' and '''+@l+''') ptsum,
(select count(1) from blogapp..album_categories c where c.userid=b.bloguserid  and c.deletetag=1   and c.createdatetime between '''+@f+''' and '''+@l+''') csum,  
(select count(1) from blogapp..album_categories c left join blogapp..album_photos ps on ps.categoriesid=c.categoriesid and ps.deletetag=1 where c.userid=b.bloguserid  and c.deletetag=1  and ps.uploaddatetime between '''+@f+''' and '''+@l+''') pssum,  
(select a.visitscount from blogapp..blog_baseconfig a where  a.userid=b.bloguserid  ) vsum
from #blogidlistTemp b order by '+@order
print @s
exec(@s)
end


drop table #blogidlistorder
drop table #blogidlistTemp

GO
