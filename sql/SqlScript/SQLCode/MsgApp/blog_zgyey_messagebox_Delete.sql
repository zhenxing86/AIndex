USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_zgyey_messagebox_Delete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[blog_zgyey_messagebox_Delete]
@messageboxid int,
@userid int
 AS

if @messageboxid = '-1'
begin
INSERT INTO blog_zgyey_messageboxdelete(messageboxid,userid,deletetime)
select @messageboxid,@userid,getdate() from blog_zgyey_messagebox a
left join blog_zgyey_messageboxdelete t3 on t3.messageboxid=a.messageboxid and t3.userid=@userid
where t3.deletetime is null 
--where not exists (select 1 from blog_zgyey_messageboxdelete d 
--where a.messageboxid=d.messageboxid and userid=@userid)

end
else if @messageboxid = '-2'
begin

INSERT INTO blog_zgyey_messageboxdelete(messageboxid,userid,deletetime)
select @messageboxid,@userid,getdate() from blog_zgyey_messagebox a
left join blog_zgyey_messageboxread t2 on t2.messageboxid=a.messageboxid and t2.userid=@userid
left join blog_zgyey_messageboxdelete t3 on t3.messageboxid=a.messageboxid and t3.userid=@userid
where t2.readtime is null and t3.deletetime is null 

--not exists (select 1 from blog_zgyey_messageboxdelete d where a.messageboxid=d.messageboxid and userid=@userid)
--and messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxread c WHERE a.messageboxid=c.messageboxid and userid=@userid)

end
else if @messageboxid = '-3'
begin
INSERT INTO blog_zgyey_messageboxdelete(messageboxid,userid,deletetime)
select @messageboxid,@userid,getdate() from blog_zgyey_messagebox a
left join blog_zgyey_messageboxread t2 on t2.messageboxid=a.messageboxid and t2.userid=@userid
left join blog_zgyey_messageboxdelete t3 on t3.messageboxid=a.messageboxid and t3.userid=@userid
where t2.readtime is not null and t3.deletetime is null 

--where not exists (select 1 from blog_zgyey_messageboxdelete d
--where a.messageboxid=d.messageboxid and userid=@userid)
--and messageboxid in(SELECT messageboxid FROM blog_zgyey_messageboxread c WHERE a.messageboxid=c.messageboxid and userid=@userid)

end
else
begin
INSERT INTO blog_zgyey_messageboxdelete(messageboxid,userid,deletetime)values(@messageboxid,@userid,getdate())
end
	IF @@ERROR <> 0 
	BEGIN 
		RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
