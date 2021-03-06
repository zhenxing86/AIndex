USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetNewCount]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remindsms_GetNewCount]
@uid int
AS
DECLARE @TempCount int
DECLARE @Tempsmscount int
DECLARE @Tempremindcount int
	

	select @Tempsmscount=count(1) from blog_messagebox  where viewstatus=0 and touserid=@uid

select @Tempremindcount=count(1) from [remindsms] a
	left join remindsmsread b1 on @uid=b1.userid and a.rid=b1.rid
	left join remindsmsdelete b2 on @uid=b2.userid and a.rid=b2.rid
	left join BasicData..[user]  b3 on @uid=b3.userid and a.kid=b3.kid
	left join BasicData..user_class  b4 on @uid=b4.userid and a.classid=b4.cid
	left join BlogApp..blog_friendlist  b5 on b5.userid=@uid and a.actionuserid=b5.frienduserid
	where b1.readtime is null and b2.deletetime is null
	and (b3.userid is not null or b4.userid is not null or b5.userid is not null)

	set @TempCount=@Tempsmscount+@Tempremindcount

	return @TempCount

GO
