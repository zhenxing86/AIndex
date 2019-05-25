USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-23
-- Description:	CardSet 只允许修改cgid列，不允许修改其他列，且不允许新增及删除
-- Memo:		
*/
ALTER TRIGGER [dbo].CardSet_Constraint ON [dbo].CardSet                           
  for INSERT, UPDATE, DELETE                           
AS
BEGIN           
	if @@RowCount <= 0 Return
	set nocount on
	IF NOT EXISTS(SELECT * FROM inserted)
	BEGIN
		raiserror('不允许删除数据',11,1)
		ROLLBACK
		RETURN
	END
	IF NOT EXISTS(SELECT * FROM deleted)
	BEGIN
		raiserror('不允许新增数据',11,1)
		ROLLBACK
		RETURN
	END

	if columns_updated()^4 > 0
	BEGIN
		raiserror('不允许更新除cgid列之外的其他列',11,1)
		ROLLBACK
		RETURN
	END    
END
GO