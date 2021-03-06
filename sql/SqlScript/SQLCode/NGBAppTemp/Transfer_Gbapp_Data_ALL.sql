USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Transfer_Gbapp_Data_ALL]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		Transfer_Gbapp_Data_ALL

select * from growthbook where 
*/
CREATE PROC [dbo].[Transfer_Gbapp_Data_ALL]
AS

DELETE NGBApp..HomeBook where kid <> 12511
DELETE NGBApp..growthbook where kid <> 12511

--园所风采数据转移

UPDATE k 
	set k.NGB_Descript = g.garten_desc,
			k.NGB_Pic = g.m_garten_photo 
	from BasicData..kindergarten k 
		cross apply
			(
			select top(1) g.garten_desc, g.m_garten_photo
				from gbapp..garteninfo g 
				where k.kid = g.kid 
				order by case when ISNULL(g.garten_desc,'')<>'' THEN 0 ELSE 1 END, g.hbid desc
			)g
where k.kid <> 12511

select classid 
	into #classid 
		from gbapp..HomeBook 
		where term = '2013-1' 
			AND ISNULL(classid,0)<>0
			and kid <> 12511
declare @cid int
while exists(select * from #classid)
BEGIN
select top(1)@cid = classid from #classid 
EXEC Ngbapp..Init_GrowthBook @cid, '2013-1'
delete #classid where classid = @cid
END
DROP TABLE #classid

--学期寄语普通版
update hb set hb.Foreword = f.foreword 
from NGBApp..HomeBook hb
	inner join gbapp..HomeBook hb1
	on hb.cid = hb1.classid 
		and hb.term = hb1.term
inner join gbapp..foreword f
		on f.hbid = hb1.hbid
		and hb1.term = '2013-1'
 where hb.kid <> 12511		
--学期寄语专业版

update hb set hb.Foreword = af.foreword,
	hb.ForewordPic = CASE WHEN af.net = 39 And ISNULL(af.foreword_photo,'null')<> 'null' then 'http://img393.zgyey.com' 
	WHEN af.net = 224 And ISNULL(af.foreword_photo,'null')<> 'null' then 'http://img224.zgyey.com' else '' end
	+ replace(af.foreword_photo,'.jpg','_small.jpg')
from NGBApp..HomeBook hb
	inner join gbapp..HomeBook hb1
	on hb.cid = hb1.classid 
		and hb.term = hb1.term
inner join gbapp..advforeword af
		on af.hbid = hb1.hbid
		and hb1.term = '2013-1'
	 where hb.kid <> 12511			
--select top 10 * from gbapp..advforeword where net=224
--net =39 (http://img393.zgyey.com/GBPhoto/20130831/3060101428914.jpg)
--net = 224(http://img224.zgyey.com/GBPhoto/20130902/15804769684007.jpg)
--我的班级
update hb set hb.ClassNotice = c.class_notice,
	hb.ClassPic = CASE WHEN c.net = 39 And ISNULL(c.m_class_photo,'null')<> 'null' then 'http://img393.zgyey.com' 
	WHEN c.net = 224 And ISNULL(c.m_class_photo,'null')<> 'null' then 'http://img224.zgyey.com' else '' end
	+ c.m_class_photo
from NGBApp..HomeBook hb
	inner join gbapp..HomeBook hb1
	on hb.cid = hb1.classid 
		and hb.term = hb1.term
inner join gbapp..classinfo c
		on c.hbid = hb1.hbid
		and hb1.term = '2013-1'
 where hb.kid <> 12511		
--幼儿表现
CREATE TABLE #Tmp_celllist
	(
	gbid int NOT NULL,
	teacher_point varchar(MAX) NULL,
	parent_point varchar(MAX) NULL,
	teacher_word varchar(MAX) NULL,
	parent_word varchar(MAX) NULL
	)

INSERT INTO #Tmp_celllist (gbid,  teacher_point, parent_point, teacher_word, parent_word)
		SELECT c.gbid, CONVERT(varchar(MAX), teacher_point), CONVERT(varchar(MAX), parent_point), 
		CONVERT(varchar(MAX), teacher_word), CONVERT(varchar(MAX), parent_word) 
		FROM GBAPP.dbo.celllist c
		 WITH (noLOCK)
		inner join GBAPP.dbo.GrowthBook gb
			on c.gbid = gb.gbid
			and gb.term = '2013-1'
			and (CONVERT(varchar(MAX), teacher_point) <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'
			OR CONVERT(varchar(MAX), parent_point) <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'
			OR CONVERT(varchar(MAX), teacher_word) <> '|||||||||||||||||||||||||||||' 
			OR CONVERT(varchar(MAX), parent_word) <> '|||||||||||||||||||||||||||||')
		inner join BasicData..User_Child uc on gb.userid = uc.userid and uc.kid <> 12511

CREATE TABLE #Tmp_advcelllist
	(
	gbid int NOT NULL,
	teacher_point varchar(MAX) NULL,
	parent_point varchar(MAX) NULL,
	teacher_word varchar(MAX) NULL,
	parent_word varchar(MAX) NULL
	)  
INSERT INTO #Tmp_advcelllist (gbid,  teacher_point, parent_point, teacher_word, parent_word)
		SELECT c.gbid, CONVERT(varchar(MAX), teacher_point), CONVERT(varchar(MAX), parent_point), 
		CONVERT(varchar(MAX), teacher_word), CONVERT(varchar(MAX), parent_word) 
		FROM GBApp.dbo.advcelllist c
		inner join GBApp..GrowthBook gb
			on c.gbid = gb.gbid
			and gb.term = '2013-1'
			and (CONVERT(varchar(MAX), teacher_point) <> '0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0'
			OR CONVERT(varchar(MAX), parent_point) <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'
			OR CONVERT(varchar(MAX), teacher_word) <> '|||||||||||||||||||||||||||||' 
			OR CONVERT(varchar(MAX), parent_word) <> '|||||||||||||||||||||||||||||')
inner join BasicData..User_Child uc on gb.userid = uc.userid and uc.kid <> 12511

SELECT a.gbid , SUBSTRING(teacher_point, n, CHARINDEX('|', teacher_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cettp 
FROM #Tmp_celllist a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + teacher_point, n, 1) = '|' 
     and teacher_point <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'

SELECT a.gbid , SUBSTRING(parent_point, n, CHARINDEX('|', parent_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetpp 
FROM #Tmp_celllist a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + parent_point, n, 1) = '|' 
     and parent_point <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'

SELECT a.gbid , SUBSTRING(teacher_word, n, CHARINDEX('|', teacher_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cettw 
FROM #Tmp_celllist a  
  JOIN commonfun.dbo.Nums1w  
    ON SUBSTRING('|' + teacher_word, n, 1) = '|' 
     and teacher_word <> '|||||||||||||||||||||||||||||'

SELECT a.gbid , SUBSTRING(parent_word, n, CHARINDEX('|', parent_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetpw 
FROM #Tmp_celllist a  
  JOIN commonfun.dbo.Nums1w  
    ON SUBSTRING('|' + parent_word, n, 1) = '|' 
     and parent_word <> '|||||||||||||||||||||||||||||'

SELECT a.gbid , SUBSTRING(teacher_point, n, CHARINDEX('|', teacher_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetadvtp 
FROM #Tmp_advcelllist a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + teacher_point, n, 1) = '|' 
     and teacher_point <> '0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0'

SELECT a.gbid , SUBSTRING(parent_point, n, CHARINDEX('|', parent_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetadvpp 
FROM #Tmp_advcelllist a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + parent_point, n, 1) = '|'
     and parent_point <> '0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0'    

SELECT a.gbid , SUBSTRING(teacher_word, n, CHARINDEX('|', teacher_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetadvtw 
FROM #Tmp_advcelllist a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + teacher_word, n, 1) = '|' 
     and teacher_word <> '|||||||||||||||||||||||||||||'

SELECT a.gbid , SUBSTRING(parent_word, n, CHARINDEX('|', parent_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #cetadvpw 
FROM #Tmp_advcelllist a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + parent_word, n, 1) = '|' 
     and parent_word <> '|||||||||||||||||||||||||||||'

set ansi_warnings off
--drop table #page_cell
CREATE TABLE #page_cell(gbid int, title INT, tp varchar(50), tw varchar(8000), pp varchar(50), pw varchar(8000))

insert into #page_cell(gbid, title, tp)
select gbid, rowno,element from  #cettp where element <> '0,0,0,0,0,0,0,0'

;MERGE #page_cell AS pc
USING (select * from  #cettw where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.tw = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,tw)
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #page_cell AS pc
USING (select * from  #cetpp where element <> '0,0,0,0,0,0,0,0')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.pp = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,pp)
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #page_cell AS pc
USING (select * from  #cetpw where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.pw = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,pw)
VALUES (mu.gbid, mu.rowno, mu.element);


CREATE TABLE #advpage_cell(gbid int, title INT, tp varchar(50), tw varchar(8000), pp varchar(50), pw varchar(8000))

insert into #advpage_cell(gbid, title, tp)
select gbid, rowno,element from  #cetadvtp where element <> '0,0,0,0,0,0,0,0,0,0'

;MERGE #advpage_cell AS pc
USING (select * from  #cetadvtw where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.tw = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,tw)
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #advpage_cell AS pc
USING (select * from  #cetadvpp where element <> '0,0,0,0,0,0,0,0')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.pp = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,pp)
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #advpage_cell AS pc
USING (select * from  #cetadvpw where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.pw = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,pw)
VALUES (mu.gbid, mu.rowno, mu.element);
set ansi_warnings on
INSERT INTO Diary_Page_Cell(gbid,pagetplid,title,TeaPoint,TeaWord,ParPoint,ParWord)
SELECT gb.gbid, 1, title - 1, ISNULL(tp,'0,0,0,0,0,0,0,0') + ',0,0', tw,ISNULL(pp,'0,0,0,0,0,0,0,0')  + ',0,0',pw 
FROM #page_cell a 
	inner join gbapp..GrowthBook gb1
		on a.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
		AND gb1.term = '2013-1'
	WHERE (a.tp IS NOT NULL or a.tw IS NOT NULL or a.pp IS NOT NULL or a.pw IS NOT NULL  )


INSERT INTO Diary_Page_Cell(gbid,pagetplid,title,TeaPoint,TeaWord,ParPoint,ParWord)
SELECT gb.gbid, 2, title - 1, tp, tw,ISNULL(pp,'0,0,0,0,0,0,0,0') + ',0,0',pw 
FROM #advpage_cell a 
	inner join gbapp..GrowthBook gb1
		on a.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
	WHERE (a.tp IS NOT NULL or a.tw IS NOT NULL or a.pp IS NOT NULL or a.pw IS NOT NULL  )

drop table #cetadvpw
drop table #cetadvtw
drop table #cetadvpp
drop table #cetadvtp
drop table #cettp
drop table #cettw
drop table #cetpp
drop table #cetpw

CREATE TABLE #Tmp_CellTarget(hbid int NOT NULL,	target varchar(MAX) NULL) 
INSERT INTO #Tmp_CellTarget (hbid, target)
	SELECT ct.hbid, CONVERT(varchar(MAX), ct.target) 
		FROM gbapp.dbo.CellTarget ct
			inner join gbapp..HomeBook hb 
				on ct.hbid = hb.hbid 
				and hb.term = '2013-1'
		where CONVERT(varchar(MAX), ct.target) <> '#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########|#########'
			and hb.kid <> 12511


SELECT a.hbid , SUBSTRING(target, n, CHARINDEX('|', target + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY hbid order by n) rowno 
into #CellTarget 
FROM #Tmp_CellTarget a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + target, n, 1) = '|' 
    
insert into NGBApp..celltarget(hbid,title,target)
	select hb.hbid, c.rowno - 1, c.element 
		from #CellTarget c 
			inner join gbapp..HomeBook hb1 
				on c.hbid = hb1.hbid
			inner join NGBApp..HomeBook hb 
				on hb.cid = hb1.classid 
				and hb1.term = hb.term
			and hb1.term = '2013-1'
	where ISNULL(c.element,'#########') <> '#########'


--//每月进步
--select top 10 * from section
CREATE TABLE dbo.#Tmp_section
	(
	gbid int NOT NULL,
	my_photo varchar(MAX) NULL,
	teacher_word varchar(MAX) NULL,
	parent_word varchar(MAX) NULL,
	my_word varchar(MAX) NULL,
	Net varchar(max)
	) 
-- alter table #Tmp_section add Net varchar(max)
-- update #Tmp_section set Net = b.Net from #Tmp_section a inner join GBApp.dbo.section b on a.gbid = b.gbid
INSERT INTO #Tmp_section (gbid,Net, my_photo, teacher_word, parent_word, my_word)
		SELECT c.gbid,CONVERT(varchar(MAX), c.net),CONVERT(varchar(MAX), c.my_photo), CONVERT(varchar(MAX), c.teacher_word), 
		CONVERT(varchar(MAX), c.parent_word), CONVERT(varchar(MAX), c.my_word)
		FROM GBApp.dbo.section c
		inner join GBApp..GrowthBook gb
			on c.gbid = gb.gbid
			and gb.term = '2013-1'
			and (CONVERT(varchar(MAX), c.my_photo) <> 'null|null|null|null|null|null|null|null|null|null|null|null'
			OR CONVERT(varchar(MAX), teacher_word) <> '|||||||||||'
			OR CONVERT(varchar(MAX), parent_word) <>  '|||||||||||'
			OR CONVERT(varchar(MAX), my_word) <>      '|||||||||||')
		inner join BasicData..User_Child uc on gb.userid = uc.userid and uc.kid <> 12511

SELECT a.gbid , SUBSTRING(my_photo, n, CHARINDEX('|', my_photo + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #section_my_photo 
FROM #Tmp_section a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + my_photo, n, 1) = '|' 
     and my_photo <> 'null|null|null|null|null|null|null|null|null|null|null|null'
SELECT a.gbid , SUBSTRING(teacher_word, n, CHARINDEX('|', teacher_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #section_teacher_word 
FROM #Tmp_section a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + teacher_word, n, 1) = '|' 
     and teacher_word <> '|||||||||||'
SELECT a.gbid , SUBSTRING(parent_word, n, CHARINDEX('|', parent_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #section_parent_word 
FROM #Tmp_section a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + parent_word, n, 1) = '|' 
     and parent_word <> '|||||||||||'
SELECT a.gbid , SUBSTRING(my_word, n, CHARINDEX('|', my_word + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #section_my_word 
FROM #Tmp_section a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + my_word, n, 1) = '|' 
     and my_word <> '|||||||||||'
SELECT a.gbid , SUBSTRING(Net, n, CHARINDEX('|', Net + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #section_net 
FROM #Tmp_section a  
  JOIN commonfun.dbo.Nums1W  
    ON SUBSTRING('|' + Net, n, 1) = '|' 
     

CREATE TABLE #page_month_sec(gbid int,net int, title INT,[MyPic] [varchar](200) ,[TeaWord] [nvarchar](1000) ,[ParWord] [nvarchar](1000) ,[MyWord] [nvarchar](1000) )
---- alter table #page_month_sec add Net int

insert into #page_month_sec(gbid, title, [MyPic])
select gbid, rowno,element from  #section_my_photo where element <> 'null'

;MERGE #page_month_sec AS pc
USING (select * from  #section_teacher_word where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.[TeaWord] = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,[TeaWord])
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #page_month_sec AS pc
USING (select * from  #section_parent_word where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.[ParWord] = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,[ParWord])
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #page_month_sec AS pc
USING (select * from  #section_my_word where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.[MyWord] = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,[MyWord])
VALUES (mu.gbid, mu.rowno, mu.element);

;MERGE #page_month_sec AS pc
USING (select * from  #section_net where element <> '')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.net = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,net)
VALUES (mu.gbid, mu.rowno, mu.element);


INSERT INTO NGBApp..Diary_page_month_sec(gbid,pagetplid,title,MyPic,TeaWord,ParWord,MyWord)
SELECT gb.gbid, 3, a.title - 1, CASE a.net WHEN 39 then 'http://img393.zgyey.com' when 224 then 'http://img224.zgyey.com' END 
+ replace(a.MyPic,'.jpg','_small.jpg'),a.TeaWord,a.ParWord,a.MyWord
FROM #page_month_sec a 
	inner join gbapp..GrowthBook gb1
		on a.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
		AND GB1.term = '2013-1'
	AND (a.MyPic IS NOT NULL or a.TeaWord IS NOT NULL or a.ParWord IS NOT NULL or a.MyWord IS NOT NULL )
		-- select * from page_month_sec
--生活剪影
insert into NGBApp..tea_UpPhoto(gbid,photo_desc,m_path,net,updatetime,deletetag,pictype)  
select gb.gbid,gp.photo_desc, CASE gp.net WHEN 39 then 'http://img393.zgyey.com' when 224 then 'http://img224.zgyey.com' ELSE '' END 
+ isnull(replace(gp.m_path,'.jpg','_small.jpg'),''),gp.net,
CASE WHEN gp.updatetime < '2013-09-01' THEN '2013-09-01' else  gp.updatetime end ,gp.deletetag,1 
from gbapp..gblifephoto gp 
	inner join gbapp..GrowthBook gb1
		on gp.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
	where gb1.term = '2013-1'
		and gb.kid <> 12511
insert into NGBApp..tea_UpPhoto(gbid,photo_desc,m_path,net,updatetime,deletetag,pictype)  
select gb.gbid,gp.photo_desc, CASE gp.net WHEN 39 then 'http://img393.zgyey.com' when 224 then 'http://img224.zgyey.com' ELSE '' END 
+ isnull(replace(gp.m_path,'.jpg','_small.jpg'),''),gp.net,
CASE WHEN gp.updatetime < '2013-09-01' THEN '2013-09-01' else  gp.updatetime end ,gp.deletetag,2 
from gbapp..gbworkphoto gp 
	inner join gbapp..GrowthBook gb1
		on gp.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
	where gb1.term = '2013-1'
		and gb.kid <> 12511
		
--手工作品gbworkphoto

--月观察与评价 gbapp..kidview--》ngbapp..page_month_evl
--gbapp..kidviewtarget---》
CREATE TABLE dbo.#Tmp_kidview
	(
	gbid int NOT NULL,
	teacher_point varchar(MAX) NULL,
	parent_point varchar(MAX) NULL
	) 
INSERT INTO #Tmp_kidview (gbid, teacher_point, parent_point)
		SELECT c.gbid, CONVERT(varchar(MAX), teacher_point), CONVERT(varchar(MAX), parent_point)
		FROM gbapp.dbo.kidview c
		inner join gbapp.dbo.GrowthBook gb
			on c.gbid = gb.gbid
			and gb.term = '2013-1'
			and (CONVERT(varchar(MAX), c.teacher_point) <> '0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0'
			OR CONVERT(varchar(MAX), parent_point) <> '0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0')
		inner join BasicData..User_Child uc on gb.userid = uc.userid and uc.kid <> 12511
		
SELECT a.gbid , SUBSTRING(teacher_point, n, CHARINDEX('|', teacher_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #kidview_teacher_point
FROM #Tmp_kidview a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + teacher_point, n, 1) = '|' 
     and teacher_point <>  '0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0'
SELECT a.gbid , SUBSTRING(parent_point, n, CHARINDEX('|', parent_point + '|', n) - n) AS element,ROW_NUMBER()OVER(PARTITION BY gbid order by n) rowno 
into #kidview_parent_point 
FROM #Tmp_kidview a  
  JOIN commonfun.dbo.Nums1Q  
    ON SUBSTRING('|' + parent_point, n, 1) = '|' 
     and parent_point <>  '0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0'     

CREATE TABLE #page_month_evl(gbid int, title INT,TeaPoint [varchar](50) ,ParPoint [varchar](50))
--ngbapp..page_month_evl

insert into #page_month_evl(gbid, title, TeaPoint)
select gbid, rowno,element from  #kidview_teacher_point where element <> '0,0,0,0,0,0,0,0,0'

;MERGE #page_month_evl AS pc
USING (select * from  #kidview_parent_point where element <> '0,0,0,0,0,0,0,0,0')
AS mu
ON (pc.gbid = mu.gbid and pc.title = mu.rowno)
WHEN MATCHED THEN
UPDATE SET pc.ParPoint = mu.element
WHEN NOT MATCHED THEN
INSERT (gbid, title,ParPoint)
VALUES (mu.gbid, mu.rowno, mu.element);

INSERT INTO NGBApp..Diary_page_month_evl(gbid,pagetplid,months,TeaPoint,ParPoint)
SELECT gb.gbid, 4, a.title - 1,ISNULL(a.TeaPoint,'0,0,0,0,0,0,0,0,0'),ISNULL(a.ParPoint,'0,0,0,0,0,0,0,0,0')
FROM #page_month_evl a 
	inner join gbapp..GrowthBook gb1
		on a.gbid = gb1.gbid
	inner join NGBApp..growthbook gb
		on gb1.userid = gb.userid 
		and gb1.term = gb.term
	  and gb1.term = '2013-1'

--家园联系册模块
DELETE NGBAPP..ModuleSet where kid <> 12511
INSERT INTO NGBAPP..ModuleSet(kid,term,hbModList,gbModList)
select DISTINCT kid,'2013-1',hbmodule, '' from GBAPP..ModuleSet where term='2013-0' AND kid <> 12511


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'旧版转新版' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Transfer_Gbapp_Data_ALL'
GO
