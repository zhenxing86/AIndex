USE mcapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:		
*/
ALTER TRIGGER In_stuinfo ON [dbo].stuinfo                           
  for INSERT, UPDATE                        
AS
BEGIN           
	if @@RowCount <= 0 Return                    
	set nocount on  
	UPDATE ub SET updatetime = GETDATE()
	FROM BasicData.dbo.user_baseinfo ub inner join inserted i 
		on ub.userid = i.stuid
	UPDATE ub SET updatetime = GETDATE()
	FROM BasicData.dbo.[user] ub inner join inserted i  
		on ub.userid = i.stuid
	
	
END