USE NGBApp
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
ALTER TRIGGER Trg_tea_UpPhoto  
   ON  dbo.tea_UpPhoto 
   AFTER INSERT
AS 
BEGIN
	if @@RowCount <= 0 Return                
	set nocount on	
	; WITH CET AS
	(
		SELECT gbid from inserted group by gbid 
	)
		INSERT INTO BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)
			select gb.kid, gb.userid, 2, 5, 5, 1
				FROM CET i 
					inner join growthbook gb
						on i.gbid = gb.gbid
					where exists(select 1 from AndroidApp..and_userinfo au where gb.userid = au.userid)
						and not exists(
						select * 
						from BasicData..MainPageList mp 
						where mp.Tag = 5 
						and mp.type = 2 
						and mp.CDate = CONVERT(VARCHAR(10), GETDATE(),120) 
						and mp.userid = gb.userid)

END
GO
