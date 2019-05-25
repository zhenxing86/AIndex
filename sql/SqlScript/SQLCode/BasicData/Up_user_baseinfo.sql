USE BasicData
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
ALTER TRIGGER Up_user_baseinfo ON user_baseinfo                           
  for UPDATE                       
AS
BEGIN           
	if @@RowCount <= 0 Return   
	if UPDATE(updatetime) Return                    
	set nocount on  
	UPDATE ub SET updatetime = GETDATE()
	FROM user_baseinfo ub inner join inserted i 
		on ub.userid = i.userid
	UPDATE u SET updatetime = GETDATE()
	FROM [user] u inner join inserted i 
		on u.userid = i.userid
	
	
END