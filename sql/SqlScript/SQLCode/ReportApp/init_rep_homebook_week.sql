USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_homebook_week]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-05-24
-- Description:	
-- Paradef: 
-- Memo: 

select *  
		from ReportApp..homebook_log hb 

exec init_rep_homebook_week 
	
*/
CREATE PROCEDURE [dbo].[init_rep_homebook_week] 
as
BEGIN

	SET NOCOUNT ON
				
	;WITH CET AS
	(
		select gbid,hbid,userid,teacher_point,0 as Isadv 
			from GBapp..celllist 
--		union all
--		select gbid,hbid,userid,teacher_point,1 as Isadv 
--			from GBapp..advcelllist 
	),
	CET1 AS
	(
		SELECT DISTINCT hbid 
			from reportapp..homebook_log
	)	
		select  cl.gbid, cl.hbid,cl.userid,
					CAST(teacher_point AS NVARCHAR(2000))teacher_point,
					hb.term,hb.classid, cs.celltype, 
					CAST(CASE WHEN cs.celltype = 2 and hb.term like '%-0' THEN LEFT(cs.cellsettings, CHARINDEX(',9月', cs.cellsettings) -1)
										WHEN cs.celltype = 2 and hb.term like '%-1' THEN STUFF(cs.cellsettings,1, CHARINDEX(',9月', cs.cellsettings), '')
							 ELSE cs.cellsettings END as nvarchar(100)) cellsettings
				into #ta
			from CET cl 
				inner join gbapp..homebook hb 
					on cl.hbid = hb.hbid 
				inner join GBApp..CellSet cs
 					on cs.cellsetid = hb.cellsetid 
				inner join BasicData.dbo.[user] u 
					on u.userid = cl.userid
				left join gbapp..MODULESET md
					on md.kid = hb.kid and md.term = hb.term
				inner join CET1 hl
					on hl.hbid = hb.hbid
				where  cl.Isadv = ISNULL( CASE WHEN ',' + md.gbmodule + ',' like '%,AdvCell,%' THEN 1 else 0 end,0)
--select * from #ta
					 
	SELECT	a.gbid,hbid,userid,term,classid,celltype, 
					SUBSTRING(teacher_point, n, CHARINDEX('|', teacher_point + '|', n) - n) AS element, 
					ROW_NUMBER()over(partition by a.gbid order by n) rowno  
		INTO #T
		FROM #ta a  
			JOIN basicdata.dbo.Nums1Q  
				ON n <=500
				AND SUBSTRING('|' + teacher_point, n, 1) = '|' 
				and SUBSTRING(teacher_point, n, CHARINDEX('|', teacher_point + '|', n) - n) <> ''       
	  
	SELECT	a.gbid , SUBSTRING(cellsettings, n, CHARINDEX(',', cellsettings + ',', n) - n) AS element, 
					ROW_NUMBER()over(partition by a.gbid order by n) rowno   
		INTO #C
		FROM #ta a  
			JOIN basicdata.dbo.Nums1Q  
				ON n <= 600  
				AND SUBSTRING(',' + cellsettings, n, 1) = ',' 
				and SUBSTRING(cellsettings, n, CHARINDEX(',', cellsettings + ',', n) - n) <> ''

	select	t.classid,t.rowno as id_index, t.hbid as homebookid, t.term , t.celltype as id_type, 
					CASE WHEN t.celltype = 1 then '第'+c.element +'周' WHEN t.celltype = 2 
							 then CASE WHEN t.celltype = 2 and t.term like '%-1' and c.element in('1月','2月')
												 THEN CAST(CAST(CAST(t.term AS VARCHAR(4)) AS INT)+ 1 as varchar(10))
												 ELSE CAST(t.term AS VARCHAR(4)) 
										END + '年' + c.element 
					ELSE '' end as title,
					COUNT(case when t.element IN('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0')  THEN NULL ELSE 1 END) as on_count,
					COUNT(case when t.element IN('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0') THEN 1 ELSE NULL END) as off_count
		into #result
		from #T t 
			inner join #C c 
				on t.gbid = c.gbid 
				and t.rowno = c.rowno
		GROUP BY t.classid,t.rowno, t.hbid, t.term, t.celltype, 
			CASE	WHEN t.celltype = 1 then '第'+c.element +'周' WHEN t.celltype = 2 
						then CASE WHEN t.celltype = 2 and t.term like '%-1' and c.element in('1月','2月')
											THEN CAST(CAST(CAST(t.term AS VARCHAR(4)) AS INT)+ 1 as varchar(10))
											ELSE CAST(t.term AS VARCHAR(4)) 
								 END + '年' + c.element 
			ELSE '' end 
	insert into ReportApp.dbo.rep_homebook_week
					 (classid, id_index, homebookid, term, id_type, title, on_count, off_count)
		select	classid, id_index, homebookid, term, id_type, title, on_count, off_count
			FROM #result

	create table #homebook_log(hbid int)
	
	UPDATE rh 
		set id_index = rs.id_index, 
				on_count = rs.on_count, 
				off_count = rs.off_count
	output inserted.homebookid
	into #homebook_log(hbid)
		from ReportApp.dbo.rep_homebook_week rh
			inner join #result rs 
				on rh.homebookid = rs.homebookid 
				and rh.term = rs.term 
				and rh.title = rs.title 					
	--select * from #homebook_log		
	insert into homebook_log_temp(hbid)
	select distinct hbid from #homebook_log	
		
	delete ReportApp..homebook_log 
		from ReportApp..homebook_log hb 
		where exists(select * from #homebook_log where hbid = hb.hbid)


	DROP TABLE #ta, #T, #C,#result,#homebook_log

END


GO
