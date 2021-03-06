USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[initBaseInfo]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	-- Author:      Master谭
	-- Create date: 2013-05-21
	-- Description:
	-- Paradef: 
	-- Memo:
	2013-0	295765	12511	46144
	exec initBaseInfo 295767
	ExceptionCount
	delete BaseInfo  where uid =  295907
	
	 exec getzzlist 43 ,9
	 MCAPP..ZZ_DICT
*/ 
CREATE PROCEDURE [dbo].[initBaseInfo]
	@uid int
AS
BEGIN
	SET NOCOUNT ON
	declare @term varchar(100), @kid int,
					@bgn datetime, @end datetime, @bid int
					
	select @kid = kid 
		from BasicData.dbo.[user] 
		where userid = @uid
					
	set @term = dbo.getTerm_New(@kid,getdate())
	IF NOT EXISTS(select * from BaseInfo where uid = @uid and term = @term)
	begin
		insert into HealthApp..BaseInfo
			(uid, kid, cid, uname, cname, gender, birthday, term, uphoto)			
			select top 1 u.userid, c.kid, uc.cid, u.name, c.cname, u.gender, u.birthday, @term, u.headpic 
				from basicdata..[user] u  
					inner join BasicData..user_class uc 
						on uc.userid = u.userid
					inner join BasicData..class c 
						on c.cid = uc.cid
				where u.userid = @uid 
					and c.deletetag = 1
	end	
	
	SELECT @bid = id 
		from BaseInfo bi 
		where bi.uid = @uid 
			and bi.term = @term	
	insert into HealthApp..ExceptionCount(bid,kid)values(@bid,@kid)		
	
	exec CommonFun.dbo.Calkidterm @kid, @term, @bgn output,	@end output 
	
	;WITH	CET0 AS
	(
		SELECT stuid,CheckDate,zz 
			FROM mcapp.dbo.stu_mc_day
			where stuid = @uid 
					and CheckDate >= @bgn
					and CheckDate < @end
	)	,CET as 
	(	
		select	CONVERT(varchar(7), sm.CheckDate, 120) mon, DAY(sm.CheckDate) dy, sm.zz
			from CET0 sm
				inner join BasicData.dbo.[user] u 
					on sm.stuid = u.userid					
			
	)select mon, dy, zz  
		into #ta 
		from cet 
		
;WITH CET AS
(
	select	sum(case when (',' + zz + ',' like '%,1,%') then 1 else 0 end) fs,  --发烧人数
					sum(case when (',' + zz + ',' like '%,2,%') then 1 else 0 end) ks,  --咳嗽人数
					sum(case when (',' + zz + ',' like '%,3,%') then 1 else 0 end) hlfy,--喉咙发炎人数  
					sum(case when (',' + zz + ',' like '%,4,%') then 1 else 0 end) lbt, --流鼻涕人数  
					sum(case when (',' + zz + ',' like '%,5,%') then 1 else 0 end) pz,  --皮疹人数  
					sum(case when (',' + zz + ',' like '%,6,%') then 1 else 0 end) fx,  --腹泻人数   
					sum(case when (',' + zz + ',' like '%,7,%') then 1 else 0 end) hy,  --红眼病人数 
					sum(case when (',' + zz + ',' like '%,8,%') then 1 else 0 end) szk, --重点观察病人数   
					sum(case when (',' + zz + ',' like '%,9,%') then 1 else 0 end) jzj, --剪指甲人数   
					sum(case when (',' + zz + ',' like '%,10,%') then 1 else 0 end) fytx, --服药提醒人数   
					sum(case when (',' + zz + ',' like '%,11,%') then 1 else 0 end) parentstake --家长带回人数   
		FROM #ta
)
	update ExceptionCount 
		set lbtcount = c.lbt,
				hlfycount = c.hlfy,
				kscount = c.ks,
				fscount = c.fs,
				hycount = c.hy,
				szkcount = c.szk,
				fxcount = c.fx,
				pccount = c.pz,
				jzjcount = c.jzj,
				fytxcount = c.fytx,
				gocount = c.parentstake,
				recentupdate = GETDATE()
		from ExceptionCount ec 
			cross join cet c 
		where ec.bid = @bid		
END

GO
