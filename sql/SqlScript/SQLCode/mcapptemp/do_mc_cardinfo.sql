USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[do_mc_cardinfo]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-04-28
-- Description:	过程用于修改卡号状态usest
-- 1）将未开卡0变成废卡-2 ；2）将已注销卡-1变成未开卡0
-- Memo:
	exec do_mc_cardinfo 123,1304000001,0
	exec do_mc_cardinfo 11061,1307002011,0
*/
CREATE PROCEDURE [dbo].[do_mc_cardinfo]
	@kid int,
	@cardno nvarchar(50),
	@usest int ,
	@userid int = 0
as
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'do_mc_cardinfo&0' --设置上下文标志	
Begin tran   
BEGIN TRY  
	SET NOCOUNT ON
	update cardinfo 
		set usest= @usest,
				userid = null,
				udate=GETDATE() 
		where kid= @kid and cardno = @cardno
	Commit tran                              
End Try      
Begin Catch      
  Rollback tran  
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
  Return  -1      
end Catch  
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
Return 1
	

GO
