USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_Rise]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：升班 
--项目名称：
--说明：
--时间：2011-5-24 14:57:22
------------------------------------
CREATE PROCEDURE [dbo].[class_Rise]
@cid int,
@newcid int
 AS 
	UPDATE class SET iscurrent=0 where cid=@cid
	UPDATE user_class set cid=@newcid where cid=@cid
	declare @kid int
	SELECT @kid=kid from class where cid=@newcid
	IF EXISTS(SELECT 1 FROM blogapp..permissionsetting WHERE kid=@kid and ptype=12)
	begin	
		insert into SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)
		select t4.kid as kid,0 as subno,t1.userid,t1.usertype,t2.name,t2.name,t4.cname as classname,'' as pwd,1,getdate() as actiondate,0 as synstatus
		from [user] t1,[user_baseinfo] t2 ,[user_class] t3,[class] t4,[child] t5
		where t1.userid=t2.userid and t3.userid=t1.userid and t3.cid=t4.cid and t5.userid=t1.userid
		and t3.cid=@newcid
	end	
	
if(@@ERROR<>0)
begin
	return (-1)
end
else
begin
	return (1)
end
GO
