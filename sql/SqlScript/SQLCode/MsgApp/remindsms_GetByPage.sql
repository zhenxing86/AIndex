USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetByPage]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[remindsms_GetByPage]
@userid int,
@viewstatus int,--表示是否已读状态0：未读，1：已读，-1：全部
@actiontypeid int,--当前的类型（-1：标识所有）
@fromid int,--当前的来源-1：所有，0：博客，1：班级，2：幼儿园。
@classid int,--班级ID（当班级等于-1的时候就是查看该幼儿园的所有班级）
@kid int,--幼儿园ID
@page int,
@size int

 AS

	
DECLARE @remindsmscount int 
DECLARE @prep int,@ignore int
DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint		
		)

DECLARE @kidurl varchar(100)--,@headpicupdate datetime,@headpic varchar(100) 

select @kidurl=sitedns from kwebcms..[site] where siteid=@kid

--select @headpicupdate=headpicupdate,@headpic=headpic 
--from BasicData..user_baseinfo a  where a.userid=@userid 
 
CREATE TABLE #reuser
(
	userid int,
	frienduserid int,
	bloguserid int
)
insert into #reuser (userid,frienduserid,bloguserid)
select d.userid,c.userid,c.bloguserid from BlogApp..blog_friendlist b
inner join BasicData.dbo.user_bloguser c on b.frienduserid=c.bloguserid 
inner join BasicData.dbo.user_bloguser d on b.userid=d.bloguserid  where d.userid=@userid

CREATE TABLE #recid
(
	lcid int
)

CREATE TABLE #reid
(
	rid int,
	actiondatetime datetime
)

create table #tempx
(
rid int,
actiondatetime datetime
)

insert into #recid(lcid)
select cid from BasicData..class b where @kid=b.kid




---------------------------------第一次过滤--------------------------------------------------------------------------

if(@classid=-1)
begin

insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
inner join #reuser r on r.frienduserid=a.actionuserid
where a.fromid=0 and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
inner join #recid c on lcid=a.classid
where  a.fromid=1 and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
where   a.kid=@kid and a.fromid=2 
and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


--insert into #tempx(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join #recid c on lcid=a.classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where   actionuserid<>@userid  
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and  @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (lcid is not null and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--)

end
else
begin


insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
inner join #reuser r on r.frienduserid=a.actionuserid
where a.fromid=0 and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
left join #recid c on lcid=a.classid
where   @classid=lcid and a.fromid=1 and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and @classid>0


insert into #tempx(rid,actiondatetime)
select a.rid,a.actiondatetime from remindsms a 
where   a.kid=@kid and a.fromid=2 
and actionuserid<>@userid  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


--insert into #tempx(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join #recid c on lcid=a.classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where   actionuserid<>@userid  
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (@classid>0 and @classid=lcid and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--)

end

-----------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------
if(@viewstatus=-1)--全部
BEGIN


--insert into #tempx(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join #recid c on lcid=a.classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where   actionuserid<>@userid  
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and
--(   @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (@classid>0 and @classid=lcid and a.fromid=1)
--or (@classid=-1 and lcid is not null and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--))


insert into #reid(rid,actiondatetime)
select a.rid,a.actiondatetime from #tempx a
left join remindsmsdelete b on @userid=b.userid and a.rid=b.rid
where b.deletetime is null 

--insert into #reid(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join remindsmsdelete b on @userid=b.userid and a.rid=b.rid
--left join #recid c on lcid=classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where b.deletetime is null and actionuserid!=@userid 
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and
--(   @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (@classid>0 and @classid=lcid and a.fromid=1)
--or (@classid=-1 and lcid is not null and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--))


set @remindsmscount=@@ROWCOUNT


IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep





		INSERT INTO @tmptable(tmptableid)
		select a.rid from #reid a  
		order by a.actiondatetime desc	
		
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
,case when (d.rid <>null) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,c.bloguserid
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
		left join remindsmsread d on @userid=d.userid and a.rid=d.rid
		inner join BasicData..user_bloguser c on a.actionuserid=c.userid 
		left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
	
		SELECT  @remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
			,case when (d.rid <>null ) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,r.bloguserid
		from remindsms a 
inner join #reid x on a.rid=x.rid
left join remindsmsread d on @userid=d.userid and a.rid=d.rid	
left join #reuser r on r.frienduserid=a.actionuserid
left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
order by x.actiondatetime desc	
			
	END


end 
-----------------------------------------------------------------------------------------------------------------------------------
else if(@viewstatus=0)--未读
BEGIN


insert into #reid(rid,actiondatetime)
select a.rid,a.actiondatetime from #tempx a
left join remindsmsdelete b on @userid=b.userid and a.rid=b.rid
left join remindsmsread m on @userid=m.userid and a.rid=m.rid
where b.deletetime is null and m.readtime is null 


set @remindsmscount=@@ROWCOUNT



IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep

		INSERT INTO @tmptable(tmptableid)
		select a.rid from #reid a  
		order by a.actiondatetime desc	
		
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
,case when (d.rid <>null) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,c.bloguserid
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
		left join remindsmsread d on @userid=d.userid and a.rid=d.rid
		inner join BasicData..user_bloguser c on a.actionuserid=c.userid 
		left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
	
		SELECT  @remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
			,case when (d.rid <>null ) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,r.bloguserid
		from remindsms a 
inner join #reid x on a.rid=x.rid
left join remindsmsread d on @userid=d.userid and a.rid=d.rid	
left join #reuser r on r.frienduserid=a.actionuserid
left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
order by x.actiondatetime desc	
			
	END

end 

-----------------------------------------------------------------------------------------------------------------------------------------
else if(@viewstatus=1)--已读
BEGIN


--insert into #tempx(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join #recid c on lcid=a.classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where   actionuserid<>@userid  
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and
--(   @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (@classid>0 and @classid=lcid and a.fromid=1)
--or (@classid=-1 and lcid is not null and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--))


insert into #reid(rid,actiondatetime)
select a.rid,a.actiondatetime from #tempx a
left join remindsmsread m on @userid=m.userid and a.rid=m.rid
where  m.readtime is not null

--insert into #reid(rid,actiondatetime)
--select a.rid,a.actiondatetime from remindsms a 
--left join remindsmsdelete b on @userid=b.userid and a.rid=b.rid
--left join remindsmsread m on @userid=m.userid and a.rid=m.rid
--left join #recid c on lcid=classid
--left join #reuser r on r.frienduserid=a.actionuserid
--where b.deletetime is null and m.readtime is not null and actionuserid!=@userid 
--and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
--and
--(   @fromid=-1 and ((r.frienduserid is not null and a.fromid=0)
--or (@classid>0 and @classid=lcid and a.fromid=1)
--or (@classid=-1 and lcid is not null and a.fromid=1)
--or (a.kid=@kid and a.fromid=2)
--))


set @remindsmscount=@@ROWCOUNT


IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep


		INSERT INTO @tmptable(tmptableid)
		select a.rid from #reid a  
		order by a.actiondatetime desc	
		
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
,case when (d.rid <>null) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,c.bloguserid
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
		left join remindsmsread d on @userid=d.userid and a.rid=d.rid
		inner join BasicData..user_bloguser c on a.actionuserid=c.userid 
		left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
	
		SELECT  @remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
			,case when (d.rid <>null ) then 1 else 0 end viewstatus,headpicupdate,headpic,@kidurl,r.bloguserid
		from remindsms a 
inner join #reid x on a.rid=x.rid
left join remindsmsread d on @userid=d.userid and a.rid=d.rid	
left join #reuser r on r.frienduserid=a.actionuserid
left join BasicData..user_baseinfo b  on b.userid=a.actionuserid
order by x.actiondatetime desc	
			
	END


end

drop table #tempx
drop TABLE #reid
drop table #reuser
drop TABLE #recid
----------------------------------------------------------------------------------------------------------------------------------


GO
