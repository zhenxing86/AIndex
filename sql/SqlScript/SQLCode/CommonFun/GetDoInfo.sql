USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetDoInfo]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 该存储过程用于读取上下文信息中的存储过程名和用户ID
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[GetDoInfo]
	@DoUserID int OUTPUT,
	@DoProc varchar(50) OUTPUT
as
BEGIN
	DECLARE @signal AS binary(100),@s VARCHAR(100),@DoUserIDs varchar(50);
	EXEC CommonFun.dbo.sp_TrgSignal_Get
  @guid = @signal OUTPUT,
  @pos  = 1;
  IF CHARINDEX('$',@signal) = 0 return
  set @s = LEFT(@signal,CHARINDEX('$',@signal)-1)
  SET @DoUserID = STUFF(@s,1,CHARINDEX('#',@s),'') 
  SET @DoProc = LEFT(@s,CHARINDEX('#',@s)-1)
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用于读取上下文信息中的存储过程名和用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDoInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDoInfo', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储过程名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDoInfo', @level2type=N'PARAMETER',@level2name=N'@DoProc'
GO
