USE NGBApp
GO
CREATE VIEW Diary_page_month_sec
AS
select d.diaryid, d.gbid, d.pagetplid, pm.title, pm.MyPic, pm.TeaWord , pm.ParWord, pm.MyWord
from Diary d
inner join page_month_sec pm 
on d.diaryid = pm.diaryid
GO

create TRIGGER trg_Diary_page_month_sec ON dbo.Diary_page_month_sec INSTEAD OF INSERT
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
	select	gbid,title, MyPic, TeaWord , ParWord, MyWord,
					ROW_NUMBER()OVER(partition by gbid order by title)rowno 
		from inserted
)
insert into page_month_sec(diaryid,title, MyPic, TeaWord , ParWord, MyWord)
	select c.diaryid, c1.title, c1.MyPic, c1.TeaWord, c1.ParWord, c1.MyWord 
		from cet c 
			inner join cet1 c1 
				on c.gbid = c1.gbid 
				and c.rowno = c1.rowno
END

GO


