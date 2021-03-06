USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetNewCountByFromId]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remindsms_GetNewCountByFromId]
@uid int,
@fromid int--当前的来源-1：所有，0：博客，1：班级，2：幼儿园。
AS

DECLARE @Tempremindcount int

if (@fromid=-1)
begin
	select @Tempremindcount=count(1) from [remindsms] a
	left join remindsmsread b1 on @uid=b1.userid and a.rid=b1.rid
	left join remindsmsdelete b2 on @uid=b2.userid and a.rid=b2.rid
	left join BasicData..[user]  b3 on @uid=b3.userid and a.kid=b3.kid
	left join BasicData..user_class  b4 on @uid=b4.userid and a.classid=b4.cid
	left join BlogApp..blog_friendlist  b5 on b5.userid=@uid and a.actionuserid=b5.frienduserid
	where b1.readtime is null and b2.deletetime is null
	and (b3.userid is not null or b4.userid is not null or b5.userid is not null)

end

else if (@fromid=0)
begin

	select @Tempremindcount=count(1) from [remindsms] a
	left join remindsmsread b1 on @uid=b1.userid and a.rid=b1.rid
	left join remindsmsdelete b2 on @uid=b2.userid and a.rid=b2.rid
	left join BlogApp..blog_friendlist  b5 on b5.userid=@uid and a.actionuserid=b5.frienduserid
	where b1.readtime is null and b2.deletetime is null
	and b5.userid is not null

--	select @Tempremindcount=count(1) from [remindsms] a where 
--	not exists(select 1 from remindsmsread b where @uid=userid and a.rid=b.rid)  
--	and not exists(select 1 from remindsmsdelete b where @uid=userid and a.rid=b.rid) 
--	and exists(select 1 from BlogApp..blog_friendlist  b where b.userid=@uid and a.actionuserid=b.frienduserid 
--	)
end

else if (@fromid=1)
begin
	select @Tempremindcount=count(1) from [remindsms] a
	left join remindsmsread b1 on @uid=b1.userid and a.rid=b1.rid
	left join remindsmsdelete b2 on @uid=b2.userid and a.rid=b2.rid
	left join BasicData..user_class  b4 on @uid=b4.userid and a.classid=b4.cid
	where b1.readtime is null and b2.deletetime is null
	and  b4.userid is not null 

end

else if (@fromid=2)
begin

select @Tempremindcount=count(1) from [remindsms] a
	left join remindsmsread b1 on @uid=b1.userid and a.rid=b1.rid
	left join remindsmsdelete b2 on @uid=b2.userid and a.rid=b2.rid
	left join BasicData..[user]  b3 on @uid=b3.userid and a.kid=b3.kid
	where b1.readtime is null and b2.deletetime is null
	and b3.userid is not null 

end


	return @Tempremindcount

GO
