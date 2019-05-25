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
ALTER TRIGGER In_teainfo ON [dbo].teainfo                           
  for INSERT, UPDATE                        
AS
BEGIN           
	if @@RowCount <= 0 Return                    
	set nocount on  
	UPDATE ub SET updatetime = GETDATE()
	FROM BasicData.dbo.user_baseinfo ub inner join inserted i 
		on ub.userid = i.teaid
	UPDATE u SET updatetime = GETDATE()
	FROM BasicData.dbo.[user] u inner join inserted i  
		on u.userid = i.teaid
	
	
END
go