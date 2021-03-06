USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[InitHomebook_V2]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from basicdata..class where cid=62671
--[InitHomebook_V2]  55906
CREATE PROCEDURE [dbo].[InitHomebook_V2]
@classid int
 AS 	

	declare @term nvarchar(20)
	declare @garten_name nvarchar(50)
	declare @class_name nvarchar(50)
	declare @grade_name nvarchar(20)
	declare @kid int
	declare @hbid int
	declare @gbid int	
	declare @cellsetid	int
	declare @sectionsetid int
	declare @modulesetid int
set @term='2014-0'
set @cellsetid=1
set @sectionsetid=1
set @modulesetid=1
declare @gid int
select @kid=kid, @class_name=cname,@gid=grade from basicdata..class where cid=@classid
select @grade_name=gname  from basicdata..grade where gid=@gid
select @garten_name = kname from basicdata..kindergarten where kid=@kid

if(exists(select 1 from moduleset where kid=@kid))
begin
	select @modulesetid=modulesetid,@cellsetid=cellsetid from moduleset where kid=@kid
end


if(not exists(select 1 from [HomeBook] where classid=@classid and [term]=@term))
begin
		INSERT INTO [GBApp].[dbo].[HomeBook]
	([garten_name],[class_name],[grade_name],[classid],[kid],[term],[createdate],[cellsetid],[modulesetid],[sectionsetid])
	VALUES(@garten_name,@class_name,@grade_name,@classid,@kid,@term,getdate(),@cellsetid,@modulesetid,@sectionsetid)

	set @hbid=@@identity

	--init forword and advforword data
	insert into foreword(hbid) values(@hbid)
	insert into advforeword(hbid) values(@hbid)
	--init garteninfo data
	if(not exists(select 1 from garteninfo where kid=@kid))	
	begin
		insert into garteninfo(hbid,kid) values(@hbid,@kid)
	end
	--init classinfo
	insert into classinfo(hbid) values(@hbid)
	--init celltarget
	insert into celltarget(hbid) values(@hbid)		

	--exec [ClassInfoRefresh] @classid


end
else
begin
	select @hbid=hbid from [HomeBook] where classid=@classid and [term]=@term
end

	
	create table #usertableList
	(
	userid int,
	name nvarchar(20),
	nickname nvarchar(20),
	gender int,
	birthday datetime
	)
	insert into #usertableList
	select t1.userid,t2.name,t2.nickname,t2.gender,t2.birthday from 
		basicdata..user_class t1 inner join basicdata..[user] t2 on t1.userid=t2.userid
	where t2.usertype=0 and t2.deletetag=1 and t1.cid=@classid and t2.gbstatus=0

	update t1 set t1.gbstatus=1 from basicdata..user_baseinfo t1 inner join #usertableList t2 on t1.userid=t2.userid
	update t1 set t1.gbstatus=1 from basicdata..[user] t1 inner join #usertableList t2 on t1.userid=t2.userid

	--select * from #usertableList
	--init growthbook
	INSERT INTO [GBApp].[dbo].[GrowthBook]([hbid],[grade_name],[term],[userid],[createdate],[cellsetid],[modulesetid],[sectionsetid])
	select @hbid,@grade_name,@term,t1.userid,getdate(),@cellsetid,@modulesetid,@sectionsetid from 
	#usertableList t1

	--init childreninfo
	INSERT INTO [GBApp].[dbo].[ChildrenInfo]([gbid],[m_my_photo],[child_name],[nick_name],[gender],[animal],[birthday],[class_name],[garten_name],[love_thing],[fear_thing],[love_food],[record],[signature],[userid])    
	select gb.gbid,'null',t3.name,t3.nickname,case t3.gender when 3 then '男' when 2 then '女' end,
	'',t3.birthday,@class_name,@garten_name,'','','','','',t3.userid
	from  #usertableList t3  left join 
	growthbook gb on gb.userid=t3.userid and gb.term=@term	

	create table #gbusertable
	(
	gbid int,
	userid int
	)
	insert into #gbusertable
	select gb.gbid,t2.userid from #usertableList t2  left join 
		growthbook gb on t2.userid=gb.userid and gb.term=@term
	--left join familyinfo f on gb.gbid=f.gbid
	--where  f.gbid is null

	--init familyinfo
	insert into familyinfo(gbid,userid)	
	select gbid,userid
	from  #gbusertable

	 --init celllist
	insert into celllist(gbid,hbid,userid)
    select gbid,@hbid,userid
	from  #gbusertable

	--init advcelllist
	insert into advcelllist(gbid,hbid,userid)
    select gbid,@hbid,userid
	from  #gbusertable

	--init kidview
	insert into kidview(gbid,hbid,userid)
    select gbid,@hbid,userid
	from  #gbusertable

	--init section
   insert into section(gbid,hbid,userid)
    select gbid,@hbid,userid
	from  #gbusertable


	--init summary
	insert into summary(gbid,hbid,userid)
	select gbid,@hbid,userid
	from  #gbusertable

	--init advsummary
	insert into advsummary(gbid,hbid,userid)
	select gbid,@hbid,userid
	from  #gbusertable

	drop table #gbusertable
	drop table #usertablelist

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END

GO
