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
CREATE TRIGGER Trg_Comment  
   ON  dbo.Comment 
   AFTER INSERT
AS 
BEGIN
	if @@RowCount <= 0 Return                
	set nocount on	
  update mp SET status = 1
		FROM BasicData..MainPageList mp
			inner join inserted i 
				on mp.Tag = 7 and mp.type =3
				and mp.TagValue = i.diaryid
				and mp.status = 0
END
GO
