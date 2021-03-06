USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_man_setting]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-22
-- Description:	过程用于插入或者删除接受园长、校医、主班老师短信的名单
-- Paradef: @result int(0：电话号码不合格，1：设置成功，2：已存在3个，不能再设置,-1：保存失败)
-- Memo:
sms_man_kid

EXEC mc_sms_man_setting 463294,12511,1
select * from sms_man_kid
EXEC mc_sms_man_setting 12511,46141,479936,3,0
SELECT * FROM basicdata.dbo.[user] where userid = 288556
*/
CREATE procedure [dbo].[mc_sms_man_setting]
	@kid int,
	@cid int,
	@userid int,
	@state int,
	@oldstate int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @cnt int, @mobile nvarchar(100)
	
	Begin tran   
	BEGIN TRY  
		if @state <> 0 
		begin
			select @mobile = u.mobile	
				from BasicData.dbo.[user]  u 
				WHERE userid = @userid		
			
			IF commonfun.dbo.fn_cellphone(@mobile) = 0 
			begin
				select 0 AS result 
				return
			end	
		end
		IF @state in(1,2)  
		BEGIN
			select @cnt = COUNT(1) 
				from sms_man_kid 
				where kid = @kid and userid <> @userid AND roletype = @state
			if @cnt >= 3
			begin
				select 2 AS result 
				return
			end	
		END	
		ELSE IF @state=3
		BEGIN
			delete sms_man_kid 
					where kid = @kid AND cid = @cid AND roletype = @state
		END
		
		if @state = 0
		begin
			if(@oldstate=3)
				delete sms_man_kid 
						where userid = @userid and cid= @cid and roletype =@oldstate
			else
				delete sms_man_kid 
						where userid = @userid and roletype =@oldstate
		end
		else 
			insert into sms_man_kid(userid,kid,cid,roletype)VALUES(@userid, @kid,@cid,@state)
			
	SELECT 1 AS result  
	
	Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran                          
		SELECT -1 AS result  
		Return        
	end Catch 
	 
	
	
END

GO
