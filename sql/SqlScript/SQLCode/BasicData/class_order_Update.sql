USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_order_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-21
-- Description:	修改班级排序
-- Memo:		

select * from class where kid = 12511 and grade = 35 order by [order]
exec class_order_Update1 70461, 1
select * from class where kid = 12511 and grade = 35 order by [order] 
*/ 
CREATE PROCEDURE [dbo].[class_order_Update]
	@cid int,
	@opt int
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'class_order_Update' --设置上下文标志	
	declare @source_order int, @target_order int, @target_cid int
	SELECT	@source_order = d1.[order],
					@target_order = d2.[order],
					@target_cid   = d2.cid 
		FROM class d1 
			outer apply
				(
					select top(1) [order], d2.cid 
						from class d2 
						where d1.kid = d2.kid 
							and d1.grade = d2.grade
							and d2.deletetag = 1 
							and d1.cid <> d2.cid
							AND ((@opt > 0 AND d2.[order] >= d1.[order])
								or (@opt < 0 AND d2.[order] <= d1.[order])							
									)							 
						order by CASE WHEN @opt > 0 then d2.[order] ELSE 9999 END, d2.[order] DESC
				)d2 WHERE d1.cid = @cid
				
	Begin tran   
	BEGIN TRY  
		update class 
			set [order] = ISNULL(@target_order,[order])
			WHERE cid = @cid	
		update class 
			set [order] = ISNULL(@source_order,[order])
			WHERE cid = @target_cid
		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志       
		Return (-1)       
	end Catch   
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
		Return (1)	

END


GO
