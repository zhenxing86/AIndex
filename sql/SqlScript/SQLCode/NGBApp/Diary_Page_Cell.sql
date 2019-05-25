USE NGBApp
GO
CREATE VIEW Diary_Page_Cell
AS
select d.diaryid, d.gbid, d.pagetplid, pc.title, pc.TeaPoint, pc.TeaWord , pc.ParPoint, pc.ParWord
from Diary d
inner join page_cell pc 
on d.diaryid = pc.diaryid
GO

create TRIGGER trg_Diary_Page_Cell ON dbo.Diary_Page_Cell INSTEAD OF INSERT
AS
BEGIN
CREATE TABLE #Diary(gbid int,diaryid BIGINT)
insert into Diary(gbid, pagetplid)
OUTPUT inserted.gbid, inserted.diaryid
into #Diary(gbid, diaryid)
select gbid, pagetplid from inserted i order by gbid,title
;with cet as
(
	select	gbid,diaryid,
					ROW_NUMBER()OVER(partition by gbid order by diaryid)rowno 
		from #Diary
), 
cet1 as
(
	select	gbid,title, TeaPoint, TeaWord , ParPoint, ParWord,
					ROW_NUMBER()OVER(partition by gbid order by title)rowno 
		from inserted
)
insert into page_cell(diaryid,title,TeaPoint,TeaWord,ParPoint,ParWord)
	select c.diaryid, c1.title, c1.TeaPoint, c1.TeaWord, c1.ParPoint, c1.ParWord 
		from cet c 
			inner join cet1 c1 
				on c.gbid = c1.gbid 
				and c.rowno = c1.rowno
END

GO


