USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-23
-- Description:	用于Cards时自动维护orderno字段
-- Memo:		
*/
CREATE TRIGGER trg_Cards_orderno ON dbo.Cards INSTEAD OF INSERT
AS
BEGIN
	if @@rowcount = 0 RETURN;
	SET NOCOUNT ON
	
	;with cet as
	(
		select cgid, MAX(orderno) MAXorderno
			from Cards 
			GROUP BY cgid
	),CET1 AS
	(
		SELECT *,ROW_NUMBER()OVER(partition by cgid order by ShowDay)rowno 
		FROM inserted
	)INSERT INTO Cards(cgid,ShowDay,orderno)
	SELECT c1.cgid, c1.ShowDay, c1.rowno + ISNULL(c.MAXorderno,0)  
		from cet1 c1 LEFT JOIN CET c ON c.cgid = c1.cgid
	
END
GO
