USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_class_Delete]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除用户班级关系记录 
--项目名称：
--说明：
--时间：2011-5-25 17:02:23
------------------------------------
CREATE PROCEDURE [dbo].[user_class_Delete]
	@cid int,
	@userid int,
	@DoUserID int = 0
 AS 
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_class_Delete' --设置上下文标志
	Begin tran   
	BEGIN TRY  
	declare @kid int,@usertype int 
	select @kid=kid,@usertype=usertype from [user] where userid=@userid and deletetag=1
		if(@cid>0 and @userid=0)
		begin
			DELETE [user_class]	 WHERE  cid=@cid
			if(@usertype>0)
			begin
			update user_class_all set deletetag=0 where userid=@userid and deletetag=1 and cid=@cid 
			and term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)
			end
		end	
		if(@userid>0 and @cid=0)
		begin
			DELETE [user_class]	 WHERE  userid=@userid
			if(@usertype>0)
			begin
			update user_class_all set deletetag=0 where userid=@userid and deletetag=1 and cid=@cid 
			and term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)
			end
		end

		if(@userid>0 and @cid>0)
		begin
			DELETE [user_class]	 WHERE  userid=@userid and cid=@cid
			if(@usertype>0)
			begin
			update user_class_all set deletetag=0 where userid=@userid and deletetag=1 and cid=@cid 
			and term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)
			end
		end
		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran 
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
		Return -1       
	end Catch  
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
		Return 1 
END

GO
