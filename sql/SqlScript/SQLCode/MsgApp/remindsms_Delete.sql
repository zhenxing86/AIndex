USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_Delete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remindsms_Delete]
@rid int,--参数-1：全部删除，-2：未读删除，-3：已读删除；
@userid int,
@actiontypeid int,
@fromid int,--当前的来源-1：所有，0：博客，1：班级，2：幼儿园。
@classid int,--班级ID（当班级等于-1的时候就是查看该幼儿园的所有班级）
@kid int
 AS
CREATE TABLE #reuser
(
	userid int,
	frienduserid int
)
insert into #reuser (userid,frienduserid)
select d.userid,c.userid from BlogApp..blog_friendlist b
inner join BasicData.dbo.user_bloguser c on b.frienduserid=c.bloguserid 
inner join BasicData.dbo.user_bloguser d on b.userid=d.bloguserid  where d.userid=@userid




if @rid = '-1'--参数-1：全部删除，
begin

----------------------------删除同时减少统计的数量要分两类处理-------------------------------------------
declare @rec int , @unrec int

select @rec=count(1) from remindsms a
where (   @fromid=-1 and (exists(select 1 from #reuser  b where b.userid=@userid and a.actionuserid=b.frienduserid and a.fromid=0)
or (@classid>0 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or (@classid=-1 and exists(select 1 from BasicData..class  b where a.classid=b.cid and  @kid=b.kid and a.fromid=1))
or exists(select 1 from BasicData..[user]  b where @userid=b.userid and a.kid=b.kid and a.fromid=2)
))
and actionuserid!=@userid 
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid) 
and exists(SELECT 1 FROM remindsmsread c WHERE a.rid=c.rid and userid=@userid)
----------------------------删除同时减少统计的数量要分两类处理-------------------------------------------

INSERT INTO remindsmsdelete(rid,userid,deletetime)
select rid,@userid,getdate() from remindsms a
where (   @fromid=-1 and (exists(select 1 from #reuser  b where b.userid=@userid and a.actionuserid=b.frienduserid and a.fromid=0)
or (@classid>0 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or (@classid=-1 and exists(select 1 from BasicData..class  b where a.classid=b.cid and  @kid=b.kid and a.fromid=1))
or exists(select 1 from BasicData..[user]  b where @userid=b.userid and a.kid=b.kid and a.fromid=2)
))
and actionuserid!=@userid 
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  

----------------------------删除同时减少统计的数量要分两类处理-------------------------------------------
--select * from remindsmscount where userid=236
--update remindsmscount set unreadcount=100,readcount=100,deletecount=100 where userid=236
--delete dbo.remindsmsdelete

set @unrec=@@ROWCOUNT
set @unrec=@unrec-@rec

update remindsmscount  set readcount=readcount-@rec,deletecount=deletecount+@rec 
where userid=@userid

update remindsmscount  set unreadcount=unreadcount-@unrec,deletecount=deletecount+@unrec 
where userid=@userid

----------------------------删除同时减少统计的数量要分两类处理-----------------------------------------
end

if @rid = '-2'--参数，-2：未读删除，
begin
INSERT INTO remindsmsdelete(rid,userid,deletetime)
select rid,@userid,getdate() from remindsms a
where (   @fromid=-1 and (exists(select 1 from #reuser  b where b.userid=@userid and a.actionuserid=b.frienduserid and a.fromid=0)
or (@classid>0 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or (@classid=-1 and exists(select 1 from BasicData..class  b where a.classid=b.cid and  @kid=b.kid and a.fromid=1))
or exists(select 1 from BasicData..[user]  b where @userid=b.userid and a.kid=b.kid and a.fromid=2)
))
and actionuserid!=@userid 
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and  not exists(SELECT 1 FROM remindsmsread c WHERE a.rid=c.rid and userid=@userid)

----------------------------删除同时减少统计的数量-------------------------------------------
update remindsmscount  set unreadcount=unreadcount-@@ROWCOUNT,deletecount=deletecount+@@ROWCOUNT 
where userid=@userid

----------------------------删除同时减少统计的数量-----------------------------------------


end

if @rid = '-3'--参数-3：已读删除
begin
INSERT INTO remindsmsdelete(rid,userid,deletetime)
select rid,@userid,getdate() from remindsms a
where (   @fromid=-1 and (exists(select 1 from #reuser  b where b.userid=@userid and a.actionuserid=b.frienduserid and a.fromid=0)
or (@classid>0 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or (@classid=-1 and exists(select 1 from BasicData..class  b where a.classid=b.cid and  @kid=b.kid and a.fromid=1))
or exists(select 1 from BasicData..[user]  b where @userid=b.userid and a.kid=b.kid and a.fromid=2)
))
and actionuserid!=@userid 
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and exists(SELECT 1 FROM remindsmsread c WHERE a.rid=c.rid and userid=@userid)

----------------------------删除同时减少统计的数量-------------------------------------------
update remindsmscount  set readcount=readcount-@@ROWCOUNT,deletecount=deletecount+@@ROWCOUNT 
where userid=@userid

----------------------------删除同时减少统计的数量-----------------------------------------

end
else
begin
if @rid >0
begin
INSERT INTO remindsmsdelete(rid,userid,deletetime)values(@rid,@userid,getdate())
-----------------------删除同时减少统计的数量--------------------------
declare @isread int
set @isread=0
select @isread=1 from remindsmsread where rid=@rid and userid=@userid
if @isread = 0
begin
update remindsmscount  set unreadcount=unreadcount-1,deletecount=deletecount+1 where userid=@userid
end 
else 
begin
update remindsmscount  set readcount=readcount-1,deletecount=deletecount+1 where userid=@userid
end
-----------------------删除同时减少统计的数量--------------------------
end
end
drop table #reuser

IF @@ERROR <> 0 
	BEGIN 
		RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END

GO
