USE mcapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-04
-- Description:	该触发器用于更新cardinfo 的udate列
-- Memo:		
*/
ALTER TRIGGER Up_cardinfo ON cardinfo                      
  for UPDATE                           
AS 
BEGIN          
	if @@RowCount <= 0 Return                    
	set nocount on  
	if not update(udate)
	update c  
		set udate=GETDATE()
		from cardinfo c
			inner join inserted i
				on c.[card]=i.[card] 
END