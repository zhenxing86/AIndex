USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_order_update]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[hcm_test_questions_order_update]
	@testid int,  
 @queestionid int,    
 @opt int  
AS
BEGIN    
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	SELECT @currentOrderNo=orderno FROM hc_test_questions WHERE questionid=@queestionid
	DECLARE @NewOrderNo int
	DECLARE @NewID int
	if(@opt=1)
	begin
	SELECT TOP 1 @NewID=questionid,@NewOrderNo=orderno FROM hc_test_questions WHERE orderno<@currentOrderNo and testid=@testid and deletetag=1  ORDER BY orderno desc
	end
	else
	begin 
	
	SELECT TOP 1 @NewID=questionid,@NewOrderNo=orderno FROM hc_test_questions WHERE orderno>@currentOrderNo and testid=@testid and deletetag=1 ORDER BY orderno asc

	end
		
	

	IF @NewID IS NULL OR @NewOrderNo IS NULL
	BEGIN
		COMMIT TRANSACTION
		RETURN 2
	END

	update hc_test_questions set orderno=@NewOrderNo where questionid=@queestionid

	update hc_test_questions set orderno=@currentOrderNo where questionid=@NewID

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
