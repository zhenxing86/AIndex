USE NGBapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 2013-12-20 
-- Description:	
-- Memo: 		
*/
ALTER TRIGGER Trg_diary  
   ON  dbo.diary 
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	if @@RowCount <= 0 Return                
	set nocount on	 
	declare @DelCnt int, @InsCnt int  
   
	SELECT @DelCnt = COUNT(1) FROM deleted  
	SELECT @InsCnt = COUNT(1) FROM inserted 
	IF @DelCnt = 0 and @InsCnt > 0 
		INSERT INTO BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)
			select gb.kid, gb.userid, 3, 7, i.diaryid, 0
				FROM inserted i 
			inner join growthbook gb 
				on i.gbid = gb.gbid 
					where exists(select 1 from AndroidApp..and_userinfo au where gb.userid = au.userid)
					and i.pagetplid not IN(SELECT pagetplid FROM DiaryExcetpPagetplid)
	ELSE IF @DelCnt > 0 and @InsCnt = 0 
	begin
		DELETE BasicData..MainPageList 
			FROM BasicData..MainPageList mp 
				inner join deleted d 
				on mp.Tag = 7 
				and mp.TagValue = d.diaryid 
	end
	ELSE IF @DelCnt > 0 and @InsCnt > 0 
	begin
		if UPDATE(deletetag)
		update mp set Status = i.deletetag 
			FROM BasicData..MainPageList mp 
				inner join deleted d 
				on mp.Tag = 7 
				and mp.TagValue = d.diaryid
				and (exists(select * from Nice where diaryid = d.diaryid)
					or exists(select * from Comment where diaryid = d.diaryid)) 
				inner join inserted i 
				on d.diaryid = i.diaryid 
	end
END
GO