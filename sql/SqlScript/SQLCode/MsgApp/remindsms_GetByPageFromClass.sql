USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetByPageFromClass]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remindsms_GetByPageFromClass]
@userid int,
@viewstatus int,--表示是否已读状态0：未读，1：已读，-1：全部
@actiontypeid int,--当前的类型（-1：标识所有）
@fromid int,--当前的来源-1：所有，0：博客，1：班级，2：幼儿园。
@classid int,--班级ID（当班级等于-1的时候就是查看该幼儿园的所有班级）
@kid int,--幼儿园ID
@page int,
@size int

 AS
--select * from dbo.remindsms
	
DECLARE @remindsmscount int 
DECLARE @prep int,@ignore int
DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint		
		)

if(@viewstatus=-1)--全部
BEGIN

select @remindsmscount=count(1) from remindsms a where 
(  (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid )
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
--end

IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep





		INSERT INTO @tmptable(tmptableid)
			SELECT 
				a.rid
		from remindsms a
		where

(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid )
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
 order by a.actiondatetime desc	
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
,case when (exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)) then 1 else 0 end viewstatus,u.headpicupdate,u.headpic
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
		left JOIN BasicData..[user] u ON a.actionuserid=u.userid 
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid
			,case when (exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)) then 1 else 0 end viewstatus,u.headpicupdate,u.headpic
		from remindsms a
left JOIN BasicData..[user] u ON a.actionuserid=u.userid
		where 
(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid
)
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
 order by a.actiondatetime desc	
			
	END


end 
else if(@viewstatus=0)--未读
BEGIN

select @remindsmscount=count(1) from remindsms a where 

(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid
)
and not exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)  
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)


IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				a.rid
		from remindsms a
		where 
(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid )
and not exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)    
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
 order by a.actiondatetime desc	
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid,0 viewstatus,u.headpicupdate,u.headpic
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
left JOIN BasicData..[user] u ON a.actionuserid=u.userid
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid,0 viewstatus,u.headpicupdate,u.headpic
		from remindsms a
left JOIN BasicData..[user] u ON a.actionuserid=u.userid
		where 
(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid )
and not exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)  
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
order by a.actiondatetime desc	
			
	END

end 
else if(@viewstatus=1)--已读
BEGIN

select @remindsmscount=count(1) from remindsms a where 
(  (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid)
and exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid) 
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)   
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
 

IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				a.rid
		from remindsms a
		where 
(  (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid)
and exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)  
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)
 order by a.actiondatetime desc	
			

		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid,1 viewstatus,u.headpicupdate,u.headpic
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			 remindsms a
		 ON 
			tmptable.tmptableid=a.rid 
left JOIN BasicData..[user] u ON a.actionuserid=u.userid
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@remindsmscount AS remindsmscount,a.rid,a.actionuserid,a.actionusername,a.actiontypeid,a.actionobjectid,a.actiondesc,a.actiondatetime,a.classid,a.kid,a.fromid,1 viewstatus,u.headpicupdate,u.headpic
		from remindsms a
left JOIN BasicData..[user] u ON a.actionuserid=u.userid
		where 
(   (@fromid=1 and exists(select 1 from BasicData..user_class  b where @userid=b.userid and a.classid=b.cid and a.fromid=1))
or actionuserid=@userid)
and exists(select 1 from remindsmsread b where @userid=b.userid and a.rid=b.rid)  
and not exists(select 1 from remindsmsdelete b where @userid=b.userid and a.rid=b.rid)  
and (@actiontypeid=-1 or actiontypeid=@actiontypeid)

			order by a.actiondatetime desc	
	END

end

GO
