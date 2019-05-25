USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	触发器用于阻止删除Class表
-- Memo:	
*/
CREATE TRIGGER Del_Class ON Class                           
  for DELETE                           
AS
BEGIN           
	if @@RowCount <= 0 Return                    
  raiserror('不允许删除数据',11,1)
	ROLLBACK
END