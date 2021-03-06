USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_CardCancel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-29
-- Description:	
-- Memo:	stuinfo_update	
*/
CREATE PROC [dbo].[stuinfo_CardCancel] 
	@kid int,
	@str varchar(max),
	@type int, -- 0 按幼儿园,1 按班级, 2 按小朋友
	@DoReason varchar(200) = null,   
	@DoUserID int
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'CardCancel&0' --设置上下文标志	
	CREATE TABLE #ID(col int)
	if @type in(1,2)
		INSERT INTO #ID
  		select distinct col 	--将输入字符串转换为列表
				from BasicData.dbo.f_split(@str,',')
	Begin tran   
	BEGIN TRY
		IF @type = 0
		BEGIN
			UPDATE cardinfo 
				set userid = null,memo=@DoReason, 
						usest = -1
				from cardinfo c 
					inner join BasicData..[User_Child] uc
						on c.userid = uc.userid
						and c.kid = @kid
		END
		ELSE IF @type = 1
		BEGIN
			UPDATE cardinfo 
				set userid = null,memo=@DoReason, 
						usest = -1
				from cardinfo c 
					inner join BasicData..[User_Child] uc
						on c.userid = uc.userid
						and c.kid = @kid
					INNER JOIN #ID u
						on uc.cid = u.col
		END  	
		ELSE IF @type= 2
		BEGIN	
			UPDATE cardinfo 
				set userid = null,memo=@DoReason, 
						usest = -1
				from cardinfo c 
					inner join #ID u
						on c.userid = u.col
						and c.kid = @kid
		END
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
		Return  -1      
	end Catch 
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
	Return 1
END 
GO
