USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_class_ADD]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条用户班级关系记录 
--项目名称：
--说明：
--时间：2011-5-25 17:02:23
------------------------------------
CREATE PROCEDURE [dbo].[user_class_ADD]
	@cid int,
	@userid int,
	@DoUserID INT = 0
 AS 
BEGIN
	SET NOCOUNT ON	
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_class_ADD' --设置上下文标志

	Begin tran   
	BEGIN TRY  
		INSERT INTO user_class(cid,userid)
			VALUES(@cid,@userid)
			declare @usertype int,@kid int
			select @kid=kid,@usertype=usertype from [user] where userid=@userid and deletetag=1
			if( not exists(
select userid from user_class_all where userid=@userid and deletetag=1 and term=CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1) and cid=@cid))
			begin
				if(@usertype>0)
				begin
				insert into user_class_all(cid,userid,term,actiondate,deletetag)
				values(@cid,@userid,CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1),GETDATE(),1)
				end
				else
				begin
				if not exists(
				select userid from user_class_all where userid=@userid and deletetag=1 and term=CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1))
				begin
				insert into user_class_all(cid,userid,term,actiondate,deletetag)
				values(@cid,@userid,CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1),GETDATE(),1)
				end
				else
				begin
				update user_class_all set term=CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1),cid=@cid where userid=@userid and deletetag=1 and term=CommonFun.dbo.fn_getCurrentTerm(@kid,dateadd(MONTH,2,GETDATE()),1)
				end
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
