USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	添加管理员
-- =============================================
CREATE PROCEDURE [dbo].[site_user_Add]
@siteid int,
@account nvarchar(60) ,
@password nvarchar(128) ,
@name nvarchar(60) ,
@usertype int
AS
BEGIN
	INSERT INTO site_user([siteid],[account],[password],[name],[createdatetime],[usertype])
	VALUES(@siteid,@account,@password,@name,getdate(),@usertype)
	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_Add', @level2type=N'PARAMETER',@level2name=N'@password'
GO
