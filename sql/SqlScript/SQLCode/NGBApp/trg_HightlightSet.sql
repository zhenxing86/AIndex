USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-23
-- Description:	用于修改CardHighlightSet,新增修改都使用insert，有则修改，无则插入
-- Memo:		
*/
ALTER TRIGGER trg_HightlightSet ON dbo.CardHighlightSet INSTEAD OF INSERT
AS
BEGIN
	if @@rowcount = 0 RETURN;
	SET NOCOUNT ON
	
	;MERGE CardHighlightSet AS ch
	USING (SELECT * FROM inserted)
	AS mu
	ON (ch.cgid = mu.cgid AND ch.HighlightDay = mu.HighlightDay)
	WHEN MATCHED THEN
	UPDATE SET ch.cardid = mu.cardid
	WHEN NOT MATCHED THEN
	INSERT (cgid, HighlightDay,cardid)
	VALUES (mu.cgid, mu.HighlightDay, mu.cardid);
	
END
GO
