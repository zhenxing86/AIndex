USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_choices_order_update]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xnl
-- ALTER date: 2014-6-10
-- Description:	答案排序 -上移，下移
-- =============================================
CREATE PROCEDURE [dbo].[hcm_test_questions_choices_order_update]
    @queestionid int,    
	@choicesid int,  
    @opt int  
AS
BEGIN    
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	SELECT @currentOrderNo=orderno FROM hc_test_questions_choices WHERE choiceid=@choicesid
	DECLARE @NewOrderNo int
	DECLARE @NewID int
	if(@opt=1)
	begin
	SELECT TOP 1 @NewID=choiceid,@NewOrderNo=orderno FROM hc_test_questions_choices WHERE orderno<@currentOrderNo and questionid=@queestionid and deletetag=1  ORDER BY orderno desc
	end
	else
	begin 
	
	SELECT TOP 1 @NewID=choiceid,@NewOrderNo=orderno FROM hc_test_questions_choices WHERE orderno>@currentOrderNo and questionid=@queestionid and deletetag=1 ORDER BY orderno asc

	end
		
	

	IF @NewID IS NULL OR @NewOrderNo IS NULL
	BEGIN
		COMMIT TRANSACTION
		RETURN 2
	END

	update hc_test_questions_choices set orderno=@NewOrderNo where choiceid=@choicesid

	update hc_test_questions_choices set orderno=@currentOrderNo where choiceid=@NewID

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN 1
	END
END


GO
