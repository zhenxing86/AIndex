USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetUnReadCount]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[remindsms_GetUnReadCount] 179643
CREATE PROCEDURE [dbo].[remindsms_GetUnReadCount]
@userid int
AS
DECLARE @TempCount int

--declare @userid int
--set @userid=179643

declare @classid int,@fromid int,@kid int
set @classid=-1
set @fromid=-1

CREATE TABLE #reuser--统计用户的朋友列表
(
	userid int,
	frienduserid int
)

select @kid=kid from BasicData..[user]
where userid=@userid

select @classid=cid from BasicData..[user] k
inner join  BasicData..user_class c on k.userid=c.userid
where k.userid=@userid and usertype in (0,1)


insert into #reuser (userid,frienduserid)
select d.userid,c.userid from BlogApp..blog_friendlist b
inner join BasicData.dbo.user_bloguser c on b.frienduserid=c.bloguserid 
inner join BasicData.dbo.user_bloguser d on b.userid=d.bloguserid  where d.userid=@userid




select @TempCount=count(1) from MsgApp..remindsms a where 

(   @fromid=-1 and (exists(select 1 from #reuser  b where b.userid=@userid and a.actionuserid=b.frienduserid and a.fromid=0)
or (@classid>0 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or (@classid=-1 and exists(select 1 from BasicData..class  b where a.classid=b.cid and  @kid=b.kid and a.fromid=1))
or exists(select 1 from BasicData..[user]  b where @userid=b.userid and a.kid=b.kid and a.fromid=2)
)
)
and actionuserid!=@userid

and not exists(select 1 from MsgApp..remindsmsread b where @userid=b.userid and a.rid=b.rid)  
and not exists(select 1 from MsgApp..remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
drop table #reuser
--print @tempCount
	return @TempCount



--select * from basicdata..[user] where account='along'

GO
