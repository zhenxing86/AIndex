USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetClassListByUserID_lv0]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[class_sms_GetClassListByUserID_lv0]
@userid int
,@kid int
,@usertype int
 AS	

	declare @hasclassid int

--SELECT @usertype=usertype FROM BasicData..[user] WHERE userid=@userid
	
if(@usertype=1)
--if(@usertype in (97,98))
		begin
			select cid as classid, @kid as kid, cname
			From BasicData.dbo.class
		    where kid=@kid and deletetag=1 and iscurrent=1 and grade <> 38 order by grade,[order] desc
		end
		else 
		begin
			select t1.cid as classid, @kid as kid, t1.cname
			  from BasicData.dbo.class t1 inner join BasicData.dbo.user_class t2 on t1.cid=t2.cid
			 where t2.userid=@userid and t1.deletetag=1 and iscurrent=1  and t1.grade <> 38 order by grade,[order] desc
		end




GO
