USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Get_qmzp]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-07
-- Description:	
-- Memo:  exec Get_qmzp 1
*/
CREATE PROC [dbo].[Get_qmzp]
@gbid int
AS
select teaword,height,weight,eye,blood,tooth,docword,DevEvlPoint,MyWord,parword
   from
   growthbook where gbid = @gbid
   

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取期末总评' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_qmzp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_qmzp', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
