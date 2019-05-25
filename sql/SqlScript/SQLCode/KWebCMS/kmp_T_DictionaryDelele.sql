USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_DictionaryDelele]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 2010-10-24
-- Description:	lx
-- =============================================
CREATE PROCEDURE [dbo].[kmp_T_DictionaryDelele]
	@kid int,
    @dic_id int
AS
BEGIN
    delete T_DictionarySetting where kid=@kid and dic_id=@dic_id
    
    IF @@ERROR<>0
      BEGIN
          RETURN 0
      END 
    ELSE 
     BEGIN
         RETURN 1
     END
   
END

GO
