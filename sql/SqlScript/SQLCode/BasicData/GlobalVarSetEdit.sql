USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-19
-- Description:	存储过程用于配置全局变量
-- Memo:	
exec BasicData..GlobalVarSetEdit 
@Name = @Name,-- '移动号码','联通号码','电信号码'
@IntValue = @IntValue, --null 默认 0玄武，8易信
@type = 1  
*/
CREATE PROCEDURE GlobalVarSetEdit
	@Name varchar(50), 
	@StrValue varchar(200) = null, 
	@IntValue int = null,
	@Type int = 2-- 0修改StrValue 1修改IntValue 2修改全部
AS
BEGIN
	SET NOCOUNT ON;
	Begin tran   
	BEGIN TRY  
		IF @Type = 0
		UPDATE GlobalVarSet SET StrValue = @StrValue WHERE Name = @Name
		IF @Type = 1
		UPDATE GlobalVarSet SET IntValue = @IntValue WHERE Name = @Name
		IF @Type = 2
		UPDATE GlobalVarSet SET StrValue = @StrValue, IntValue = @IntValue WHERE Name = @Name
	Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  0      
	end Catch  
	Return 1
   
END
GO
