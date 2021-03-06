USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[enlistonline_Update]
@id int,
@siteid int,
@name nvarchar(50)='',
@sex bit,
@birthday datetime,
@contactphone nvarchar(50)='',
@contactaddress nvarchar(200)='',
@memo nvarchar(500)=''
AS
BEGIN
    UPDATE enlistonline
    SET siteid=@siteid,name=@name,sex=@sex,birthday=@birthday,contactphone=@contactphone,contactaddress=@contactaddress,memo=@memo
    WHERE id=@id

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonline_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonline_Update', @level2type=N'PARAMETER',@level2name=N'@birthday'
GO
