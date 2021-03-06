USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetClassListByUserID_lv1]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------
CREATE PROCEDURE [dbo].[class_sms_GetClassListByUserID_lv1]
@userid int
,@kid int
,@usertype int
AS

DECLARE @isvipcontrol INT
SELECT @isvipcontrol=isvipcontrol FROM KWebCMS.dbo.site_config WHERE siteid=@kid

create table #gradelist
(
lid int IDENTITY(1,1)
,lcid int
,lcname nvarchar(30)
)

create table #classlist
(
tcid int
,pcount int
)

	if(@usertype=1)
	--if(@usertype in (97,98))
		begin
			insert into #gradelist(lcid,lcname)
			select cid as classid, cname
			From BasicData.dbo.class
		    where kid=@kid and deletetag=1 and iscurrent=1 
		    and grade <> 38 order by grade,[order] desc
		end
		else 
		begin
			insert into #gradelist(lcid,lcname)
			select t1.cid as classid,t1.cname
			  from BasicData.dbo.class t1 
			  inner join BasicData.dbo.user_class t2 on t1.cid=t2.cid
			 where t2.userid=@userid 
			 and t1.deletetag=1 
			 and iscurrent=1  
			 and t1.grade <> 38  
			 and t1.kid=@kid
			 order by grade,[order] desc
		end

	IF(@isvipcontrol=0 or @isvipcontrol is null)
	BEGIN
				
			 insert into #classlist(tcid,pcount)
			 select lcid,count(t3.userid) from #gradelist t
		     inner join BasicData.dbo.user_class t3 on t3.cid=t.lcid
		     inner join BasicData.dbo.[user] t1 on t3.userid=t1.userid
		    
		     where 
		     t1.deletetag=1 
		     and commonfun.dbo.fn_cellphone(t1.mobile) = 1  
		     and t1.usertype=0
		     and t1.kid=@kid
		     group by lcid
		     
	END
	ELSE
	BEGIN

			 insert into #classlist(tcid,pcount)
			 select lcid,count(t3.userid) from #gradelist t
		     inner join BasicData.dbo.user_class t3 on t3.cid=t.lcid
		     inner join BasicData.dbo.[user] t1 on t3.userid=t1.userid
		     inner join BasicData.dbo.child t4 on t3.userid=t4.userid
		     inner join ossapp..addservice t5 
				on t5.[uid]=t1.userid
					and t5.deletetag=1
					and t5.describe='开通'
					and t5.a2='801'
					and t5.kid=t1.kid
		     where   t1.deletetag=1 
					 and commonfun.dbo.fn_cellphone(t1.mobile) = 1 
					 and t4.VIPStatus=1 
					 and t1.usertype=0
					 and t1.kid=@kid
		     group by lcid
		     
		 
		  
		     
	END



SELECT lcid,@kid,lcname,sum(pcount) FROM #gradelist
left join #classlist on tcid=lcid
group by lcid,lcname,lid
order by lid



drop table #classlist
drop table #gradelist


GO
