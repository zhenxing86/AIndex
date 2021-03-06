USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_ADD]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remindsms_ADD]
@actionuserid int,
@actionusername nvarchar(20),
@actiontypeid int,
@actionobjectid int,
@actiondesc nvarchar(200),
@actiondatetime datetime,
@classid int,
@kid int,
@fromid int--当前的来源-1：所有，0：博客，1：班级，2：幼儿园。

 AS
INSERT INTO [remindsms](
	[actionuserid],[actionusername],[actiontypeid],[actionobjectid],[actiondesc],[actiondatetime],[classid],[kid],[fromid]
	)VALUES(
	@actionuserid,@actionusername,@actiontypeid,@actionobjectid,@actiondesc,@actiondatetime,@classid,@kid,@fromid
	)



if(@fromid=2)--全园
BEGIN


insert into remindsmscount(userid,unreadcount,readcount,deletecount)
select b1.userid ,0,0,0 from BasicData..[user] b1
left join remindsmscount r on r.userid=b1.userid
where b1.kid =@kid and r.ID is null



update remindsmscount  set unreadcount=unreadcount+1
from BasicData..[user] b1 
where b1.kid =@kid and remindsmscount.userid=b1.userid 

end
else if(@fromid=1)--班级
BEGIN

insert into remindsmscount(userid,unreadcount,readcount,deletecount)
select b1.userid ,0,0,0 from BasicData..user_class b1
left join remindsmscount r on r.userid=b1.userid
where cid=@classid and r.ID is null

--update remindsmscount  set unreadcount=unreadcount+1
--where exists(select top 1 1 from BasicData..user_class b1 
--where cid=@classid and remindsmscount.userid=b1.userid)

update remindsmscount  set unreadcount=unreadcount+1
from BasicData..user_class b1 
where b1.cid =@classid and remindsmscount.userid=b1.userid 



end
else if(@fromid=0)--博客
BEGIN

insert into remindsmscount(userid,unreadcount,readcount,deletecount)
select c1.userid frienduserid,0,0,0 from BlogApp..blog_friendlist b1
inner join BasicData.dbo.user_bloguser c1 on b1.frienduserid=c1.bloguserid 
inner join BasicData.dbo.user_bloguser d1 on b1.userid=d1.bloguserid  
left join remindsmscount r on r.userid=c1.userid
where d1.userid=@actionuserid and r.ID is null


update remindsmscount  set unreadcount=unreadcount+1
from BlogApp..blog_friendlist b1
inner join BasicData.dbo.user_bloguser c1 on b1.frienduserid=c1.bloguserid 
inner join BasicData.dbo.user_bloguser d1 on b1.userid=d1.bloguserid  
where d1.userid=@actionuserid and remindsmscount.userid=c1.userid



--update remindsmscount  set unreadcount=unreadcount+1
--where exists(select top 1 1 from BlogApp..blog_friendlist b1
--inner join BasicData.dbo.user_bloguser c1 on b1.frienduserid=c1.bloguserid 
--inner join BasicData.dbo.user_bloguser d1 on b1.userid=d1.bloguserid  
--where d1.userid=@actionuserid and remindsmscount.userid=c1.userid)


end


	IF(@@ERROR<>0)
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN @@IDENTITY
	END

GO
