USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_symptom_List_class]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

rep_table_symptom_List_ds 12511,46144, '2013-04-16'
*/
CREATE PROC [dbo].[rep_table_symptom_List_class]
	@kid  int,
	@cid  int,
	@checktime1 datetime
as
BEGIN
SET NOCOUNT ON

	;WITH CET0 AS
	(
	select cid, checktime,
			case when (','+ result like '%,1,%') then 1 else 0 end fs,  --发烧人数
			case when (','+ result like '%,2,%') then 1 else 0 end ks,  --咳嗽人数
			case when (','+ result like '%,3,%') then 1 else 0 end hlfy,--喉咙发炎人数  
			case when (','+ result like '%,4,%') then 1 else 0 end lbt, --流鼻涕人数  
			case when (','+ result like '%,5,%') then 1 else 0 end pz,  --皮疹人数  
			case when (','+ result like '%,6,%') then 1 else 0 end fx,  --腹泻人数   
			case when (','+ result like '%,7,%') then 1 else 0 end hy,  --红眼病人数   
			case when (','+ result like '%,8,%') then 1 else 0 end szk, --重点观察病人数   
			case when (','+ result like '%,9,%') then 1 else 0 end jzj, --剪指甲人数   
			case when (','+ result like '%,10,%') then 1 else 0 end fytx, --服药提醒人数   
			case when (','+ result like '%,11,%') then 1 else 0 end parentstake --家长带回人数
			, uname  
		from rep_mc_child_checked_detail where kid = @kid and cid = @cid
	),
 CET AS
	(
	SELECT TOP 8
				RIGHT(CONVERT(varchar(20),StartT,102),5) +'-' 
			 +RIGHT( CONVERT(varchar(20),dateadd(dd,-1,EndT),102),5) weekdate, 
				StartT, EndT
		FROM BasicData.dbo.WeekList 
		where StartT <= @checktime1
		order by StartT desc
	)  
	SELECT weekdate, ISNULL(fs,0)fs, ISNULL(hlfy,0)hlfy, ISNULL(ks,0)ks, ISNULL(lbt,0)lbt, 
			ISNULL(fx,0)fx, ISNULL(hy,0)hy, ISNULL(szk,0)szk, ISNULL(pz,0)pz, ISNULL(fytx,0)fytx, 
			ISNULL(jzj,0)jzj, ISNULL(parentstake,0)parentstake, uname  , CAST(0 as int)weakcount	
	into #T1
		FROM CET c1  
			inner JOIN CET0 c2 
				on c2.checktime > = c1.StartT 
				and c2.checktime < c1.EndT
		
	SELECT weekdate, SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy, 
			SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake				
		from #T1 
		GROUP BY weekdate
	UNION 
	SELECT '合计', SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy, 
				SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake				
		from #T1
	
SELECT weekdate, SUM(fs)fs, SUM(hlfy)hlfy, SUM(ks)ks, SUM(lbt)lbt, SUM(fx)fx, SUM(hy)hy, 
		SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake, 
		SUM(fs)+ SUM(hlfy)+ SUM(ks)+ SUM(lbt)+ SUM(fx)+ SUM(hy)+ SUM(szk)+ SUM(pz)+ 
		SUM(fytx)+ SUM(jzj)+ SUM(parentstake)total, uname ,weakcount
	from #T1 
	GROUP BY weekdate, uname ,weakcount
	order by weekdate
  
END


GO
