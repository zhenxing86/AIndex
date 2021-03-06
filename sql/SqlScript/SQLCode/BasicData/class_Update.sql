USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	修改一条班级记录
-- Memo:		
SELECT * FROM CLASS WHERE KID = 12511
DECLARE @D INT
EXEC @D = class_Update 93991,'比比ee班',36,'小一班'
SELECT @D
SELECT * FROM CLASS WHERE KID = 12511

*/ 
CREATE PROCEDURE [dbo].[class_Update]
	@cid int,
	@cname nvarchar(20),
	@grade int,
	@sname nvarchar(20)
AS 	
BEGIN 
	SET NOCOUNT ON
	DECLARE @kid int, @oldgrade int
	
	SELECT @kid = kid, @oldgrade = grade 
		FROM class 
		WHERE cid = @cid	
		
	IF EXISTS
		(
			SELECT 1 
				FROM class 
				where kid = @kid 
					AND cname = @cname 
					and cid <> @cid 
					and deletetag = 1 
					and iscurrent = 1
		)
	BEGIN
		RETURN (-2)
	END
	ELSE
	BEGIN
	   --修改教学计划的名称
   declare @curyear varchar(50),@cur_term varchar(50),@term varchar(50)
   set @curyear= DateName(year,GETDATE())
       
		 
                          
 select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),0)     
    select @cur_term=col2                  
    from CommonFun.dbo.fn_MutiSplitTSQL(@term,'$','-')   
      update EBook..PB_PlanBook  set classname= @cname where   classid=@cid  and [year]= @curyear and  term=@cur_term   
		IF(@grade <> @oldgrade)
		BEGIN		
			DECLARE @nextorder int	
			SELECT @nextorder = max(isnull([order],0)) + 1 
				FROM class 
				WHERE kid = @kid 
					and grade = @grade
			EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'class_Update' --设置上下文标志	
			Begin tran   
			BEGIN TRY  
				UPDATE class 
					SET cname = @cname,
							grade = @grade,
							sname = @sname,
							[order] = @nextorder	
					WHERE cid = @cid 

				;WITH CET AS
				(
					SELECT *,ROW_NUMBER()OVER(order BY [order]) rowno
						FROM Class 
						WHERE grade = @oldgrade 
							and kid = @kid
				)
					UPDATE CET SET [order] = rowno
		
      
				Commit tran                              
			End Try      
			Begin Catch      
				Rollback tran   
				EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志   
				Return (-1)       
			end Catch  
		END
		ELSE
		BEGIN
			Begin tran   
			BEGIN TRY  
				UPDATE class 
					SET cname = @cname,
							sname = @sname 
					WHERE cid = @cid
					
					     
				Commit tran                              
			End Try      
			Begin Catch      
				Rollback tran   
				EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志   
				Return (-1)       
			end Catch  
		END
		EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志   
		Return (1)	
	END
END

GO
