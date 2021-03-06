USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description:	
-- Memo:		
select * from [user] where userid = 295765
select * from [user_baseinfo] where userid = 295765
exec user_Update 295765, 'dmzzzx','志轩test2','2009-04-22',3,'18028633611','2013-03-19',''

select * from [user] where userid = 295765
select * from [user_baseinfo] where userid = 295765
*/ 
CREATE PROCEDURE [dbo].[user_Update]
	@userid int,
	@account nvarchar(50),
	@name nvarchar(20),
	@birthday datetime,
	@gender int,
	@mobile nvarchar(11),
	@enrollmentdate datetime,
	@enrollmentreason varchar(300),
	@DoUserID int = 0
 AS 
BEGIN
	SET NOCOUNT ON
	
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_Update' --设置上下文标志
	
	if(year(@birthday) = 1900)
	begin
		set @birthday = null
	end
	if(year(@enrollmentdate) = 1900)
	begin
		set @enrollmentdate = null
	end

	declare @kid int
	select @kid = kid 
		from [user] 
		where userid = @userid

	Begin tran   
	BEGIN TRY  
			UPDATE [user] 
			SET account = @account,
					name = @name,
					nickname=@name,
					birthday = @birthday,
					gender = @gender,
					mobile = @mobile,
					enrollmentdate = @enrollmentdate,
					enrollmentreason=@enrollmentreason 
			WHERE userid = @userid
		UPDATE user_baseinfo 
			SET name = @name,
					nickname = @name,
					birthday = @birthday,
					gender = @gender,
					mobile = @mobile,
					enrollmentdate = @enrollmentdate,
					enrollmentreason=@enrollmentreason
			WHERE userid = @userid	
		Commit tran                              
	End Try      
	Begin Catch  
    if @@TRANCOUNT > 0 Rollback tran 
		
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
    print -1       
		Return -1
	end Catch  
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
    print 1       
		Return 1   
		    
END





GO
