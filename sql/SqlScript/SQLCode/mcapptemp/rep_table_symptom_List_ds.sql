USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_symptom_List_ds]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-04-28
-- Description:	过程用于生成 近期高发症状分析(学校)
-- Memo:
rep_table_symptom_List_ds 8812, '2013-04-16'
*/
CREATE PROC [dbo].[rep_table_symptom_List_ds]
	@kid  int,
	@checktime1 datetime
as
BEGIN
SET NOCOUNT ON

	;WITH CET AS
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
			ISNULL(jzj,0)jzj, ISNULL(parentstake,0)parentstake, cid, cname, CAST(0 as int)weakcount	
	into #T1
		FROM CET c  
			left JOIN mcapp.dbo.rep_mc_class_checked_sum rm 
				on rm.cdate > = c.StartT 
				and rm.cdate < c.EndT
			  and ISNULL(rm.gid,0) <> 38  
		WHERE rm.kid = @kid 
		
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
		SUM(fytx)+ SUM(jzj)+ SUM(parentstake)total,cid,cname,weakcount
	from #T1 
	GROUP BY weekdate,cid,cname,weakcount
	order by weekdate
  
END


GO
