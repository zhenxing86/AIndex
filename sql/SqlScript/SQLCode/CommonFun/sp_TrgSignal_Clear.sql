USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[sp_TrgSignal_Clear]    Script Date: 2014/11/24 22:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*清除上下文标志过程*/
CREATE PROC [dbo].[sp_TrgSignal_Clear]
  @pos  AS INT
AS

DECLARE @ci AS VARBINARY(128);
SET @ci = 
  ISNULL(SUBSTRING(CONTEXT_INFO(), 1, @pos-1),
         CAST(REPLICATE(0x00, @pos-1) AS VARBINARY(128)))
  + CAST(REPLICATE(0x00, 100) AS VARBINARY(128)) +
  ISNULL(SUBSTRING(CONTEXT_INFO(), @pos+100, 128-100-@pos+1), 0x);
SET CONTEXT_INFO @ci;

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'清除上下文标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_TrgSignal_Clear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_TrgSignal_Clear', @level2type=N'PARAMETER',@level2name=N'@pos'
GO
