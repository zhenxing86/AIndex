USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_ChildUserClass_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-5-28
-- Description:	加入班级
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_ChildUserClass_Add]
	@cid int,
	@userid int,
	@kid int
AS
BEGIN
	SET NOCOUNT ON 
	Begin tran   
	BEGIN TRY  
		INSERT INTO user_kindergarten(userid,kid) 
			VALUES(@userid,@kid)
		update [user] set kid = @kid 
			where userid = @userid       
		INSERT INTO user_class(cid,userid)  
			VALUES(@cid,@userid) 
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -2      
	end Catch  
	Return @userid
 
END

GO
