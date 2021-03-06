USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[zxbm_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[zxbm_Add]
@siteid int,
@name nvarchar(50)='',
@sex nvarchar(2),
@birthday nvarchar(10),
@fname nvarchar(50)='',
@fjob nvarchar(500)='',
@fphone nvarchar(50)='',
@mname nvarchar(50)='',
@mjob nvarchar(50)='',
@mphone nvarchar(50)='',
@address nvarchar(100)='',
@oldkin nvarchar(100)='',
@joinclass nvarchar(50)='',
@memo nvarchar(200)='',
@homephone nvarchar(50),
@fzw nvarchar(50),
@mzw nvarchar(50)

AS
BEGIN
    INSERT INTO [KWebCMS].[dbo].[zxbm]
           ([name]
           ,[sex]
           ,[birthday]
           ,[fname]
           ,[fjob]
           ,[fphone]
           ,[mname]
           ,[mjob]
           ,[mphone]
           ,[address]
           ,[oldkin]
           ,[joinclass]
           ,[memo]
           ,[siteid],[homephone],[fzw],[mzw])
     VALUES
           (@name
           ,@sex
           ,@birthday
           ,@fname
           ,@fjob
           ,@fphone
           ,@mname
           ,@mjob
           ,@mphone
           ,@address
           ,@oldkin
           ,@joinclass
           ,@memo
           ,@siteid,@homephone,@fzw,@mzw)
    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN @@IDENTITY
    END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'zxbm_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'zxbm_Add', @level2type=N'PARAMETER',@level2name=N'@birthday'
GO
