USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetGradeList_lv1]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------
CREATE PROCEDURE [dbo].[class_sms_GetGradeList_lv1]
@kid int
AS
DECLARE @isvipcontrol INT
SELECT @isvipcontrol=isvipcontrol FROM KWebCMS.dbo.site_config WHERE siteid=@kid

create table #gradelist
(
lgid int
,lgname nvarchar(30)
,lcid int
)

create table #classlist
(
tcid int 
,pcount int
)

	insert into #gradelist(lgid,lgname,lcid)
	SELECT gid,gname,t2.cid FROM BasicData.dbo.grade t1 
		inner join BasicData.dbo.class t2
			on t1.gid=t2.grade
			where t2.kid=@kid 
				and t2.deletetag=1 
				and t2.iscurrent=1 
				AND t2.grade<>38

	IF(@isvipcontrol=0 or @isvipcontrol is null)
	BEGIN	
			 insert into #classlist(tcid,pcount)
			 select t3.cid,count(t3.userid) from BasicData.dbo.user_class t3
				 inner join BasicData.dbo.[user] t1 
					on t3.userid=t1.userid
				 inner join #gradelist t5
					on t3.cid=t5.lcid
				
		     where t1.deletetag=1
				 and commonfun.dbo.fn_cellphone(t1.mobile) = 1
				 and t1.usertype=0 
				 and t1.kid=@kid
		     group by t3.cid
		     
		     
		     
		     
		     
	END
	ELSE
	BEGIN
		     insert into #classlist(tcid,pcount)
			 select t3.cid,count(t3.userid) from BasicData.dbo.user_class t3
				 inner join BasicData.dbo.[user] t1 
					on t3.userid=t1.userid
				 inner join BasicData.dbo.child t4 
					on t3.userid=t4.userid
				 inner join #gradelist t5
					on t3.cid=t5.lcid
				 inner join ossapp..addservice a 
					on a.[uid]=t1.userid
					and a.deletetag=1
					and a.describe='开通'
					and a.a2='801'
					and a.kid=t1.kid
		     where t1.deletetag=1
				 and commonfun.dbo.fn_cellphone(t1.mobile) = 1 
				 and t4.VIPStatus=1 
				 and t1.usertype=0 
				 and t1.kid=@kid
		     group by t3.cid
		     
	END

		SELECT lgid,lgname,sum(pcount) 
			FROM #gradelist
				left join #classlist
					on tcid=lcid
			group by lgid,lgname
			ORDER BY lgid

drop table #classlist
drop table #gradelist

GO
