USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_votelog_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-06
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[MH_votelog_Add]
@siteid int,
@fromip nvarchar(20)='',
@result nvarchar(50)=''
AS
BEGIN
    INSERT INTO votelog([siteid],[fromip],[result],[createdatetime])
    VALUES(@siteid,@fromip,@result,GETDATE()) 

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_votelog_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
