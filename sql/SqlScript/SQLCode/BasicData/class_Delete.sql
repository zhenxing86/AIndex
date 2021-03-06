USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_Delete]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	删除一条班级记录
-- Memo:		select * from class where kid = 12511

*/ 
CREATE PROCEDURE [dbo].[class_Delete]
	@cid int,
	@userid int,
	@douserid int =0
AS
BEGIN
	SET NOCOUNT ON 
  IF NOT EXISTS
		(
			SELECT * 
				FROM user_class uc 
				left join leave_kindergarten k on uc.userid=k.userid
					inner join [user] u 
						on uc.userid = u.userid  
					
				where uc.cid = @cid and k.ID is null
					and uc.userid <> @userid 
					and u.deletetag = 1
		
		)	
 	BEGIN
 	Begin tran   
	BEGIN TRY  
	declare @kid int
 select @kid=kid from class where cid=@cid and iscurrent=1 and deletetag=1  
		UPDATE class SET deletetag = 0 WHERE cid = @cid 
		DELETE user_class WHERE cid = @cid
		  --update class_all set iscurrent=0,deletetag=0 where cid=@cid and iscurrent=1 and deletetag=1 and term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)

		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return        
	end Catch   
 	END
 	ELSE
 	BEGIN
 		return (-2)
 	END
END

GO
