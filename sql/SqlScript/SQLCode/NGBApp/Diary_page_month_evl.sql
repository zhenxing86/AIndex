USE NGBApp
GO
ALTER VIEW Diary_page_month_evl
AS
select d.diaryid, d.gbid, d.pagetplid, pm.months, pm.TeaPoint, pm.ParPoint 
from Diary d
inner join page_month_evl pm 
on d.diaryid = pm.diaryid
GO

ALTER TRIGGER trg_Diary_page_month_evl ON dbo.Diary_page_month_evl INSTEAD OF INSERT
AS
BEGIN
CREATE TABLE #Diary(gbid int,diaryid BIGINT)
insert into Diary(gbid, pagetplid)
OUTPUT inserted.gbid, inserted.diaryid
into #Diary(gbid, diaryid)
select gbid, pagetplid from inserted i order by gbid,months
;with cet as
(
	select	gbid,diaryid,
					ROW_NUMBER()OVER(partition by gbid order by diaryid)rowno 
		from #Diary
), 
cet1 as
(
	select	gbid, months, TeaPoint, ParPoint ,
					ROW_NUMBER()OVER(partition by gbid order by months)rowno 
		from inserted
)
insert into page_month_evl(diaryid,months,TeaPoint,ParPoint)
	select c.diaryid, c1.months, c1.TeaPoint, c1.ParPoint
		from cet c 
			inner join cet1 c1 
				on c.gbid = c1.gbid 
				and c.rowno = c1.rowno
END

GO


