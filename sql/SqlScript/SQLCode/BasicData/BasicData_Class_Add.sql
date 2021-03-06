USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_Class_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  liaoxin  
-- Create date: 2011-5-30  
-- Description: 老师创建班级  
-- =============================================  
CREATE PROCEDURE [dbo].[BasicData_Class_Add]  
	@kid int,  
	@cname varchar(50),  
	@grade int,  
	@sname varchar(50),  
	@iscurrent int,  
	@userid int  
AS  
BEGIN   
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'BasicData_Class_Add' --设置上下文标志
  BEGIN TRANSACTION  
  DECLARE @order int,@cid int  
  SELECT @order=MAX([order])+1 from class   
    
  INSERT INTO class(kid,cname,grade,[order],deletetag,sname,actiondate,iscurrent) VALUES (@kid,@cname,@grade,@order,0,@sname,GETDATE(),1)  
  SET @cid=ident_current('class')  
    
  INSERT search_class(cid,kid, cname,gname,semester,actiondate,childnumber) values (@cid,@kid, @cname,@grade,@sname ,GETDATE(),0)  
    
  INSERT INTO user_class(cid,userid) VALUES (@cid,@userid)  
    
  IF @@ERROR<>0  
  BEGIN  
    ROLLBACK TRANSACTION  
       EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
    RETURN 0  
  END  
  ELSE  
  BEGIN  
  COMMIT TRANSACTION  
     EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
  Return @cid  
  END  
END  
  
  
  
  
GO
