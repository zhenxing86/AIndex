USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_ReDelete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[remindsms_ReDelete] 7,148575,2

CREATE PROCEDURE [dbo].[remindsms_ReDelete]
@actiontypeid int,
@actionobjectid int,
@fromid int

 AS


----------------------------------------------------------------------------------------------------------------------
declare @actionuserid int,
@isread int,
@rid int,
@classid int,
@kid int

select @actionuserid=actionuserid,@rid=rid,@classid=classid,@kid=kid from remindsms where actiontypeid=@actiontypeid and actionobjectid=@actionobjectid and fromid=@fromid
delete  remindsms where actiontypeid=@actiontypeid and actionobjectid=@actionobjectid and fromid=@fromid

if(@fromid=2)--全园
BEGIN


update remindsmscount  set readcount=readcount-1,deletecount=deletecount+1
from remindsmsread r
inner join BasicData..[user] b1 on r.userid=b1.userid 
where b1.kid =@kid and r.rid=@rid and remindsmscount.userid=b1.userid


update remindsmscount  set unreadcount=unreadcount-1,deletecount=deletecount+1
from BasicData..[user] b1 
left join remindsmsread r on r.userid=b1.userid 
where b1.kid =@kid and r.rid=@rid and remindsmscount.userid=b1.userid and r.readtime is null



end
else if(@fromid=1)--班级
BEGIN



update remindsmscount  set readcount=readcount-1,deletecount=deletecount+1
from remindsmsread r
inner join BasicData..user_class b1 on r.userid=b1.userid 
where b1.cid =@classid and r.rid=@rid and remindsmscount.userid=b1.userid


update remindsmscount  set unreadcount=unreadcount-1,deletecount=deletecount+1
from BasicData..user_class b1 
left join remindsmsread r on r.userid=b1.userid 
where b1.cid =@classid and r.rid=@rid and remindsmscount.userid=b1.userid and r.readtime is null





end
else if(@fromid=0)--博客
BEGIN

set @isread=0
select @isread=1 from remindsmsread where rid=@rid and userid=@actionuserid
if @isread = 0
begin
update remindsmscount  set unreadcount=unreadcount-1,deletecount=deletecount+1 where userid=@actionuserid
end 
else 
begin
update remindsmscount  set readcount=readcount-1,deletecount=deletecount+1 where userid=@actionuserid
end


end


-----------------------------------------------------------------------------------------------------------------------




 
IF @@ERROR <> 0 
	BEGIN 
		RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END

GO
