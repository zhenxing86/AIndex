USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_UpdateByCMS]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-01-13
-- Description:	站点更新
-- =============================================
CREATE PROCEDURE [dbo].[site_UpdateByCMS]
@siteid int,
@name nvarchar(50)='',
@description nvarchar(300)='',
@address nvarchar(500)='',
@sitedns nvarchar(100)='',
@provice int,
@city int,
@contractname nvarchar(30)='',
@QQ nvarchar(20)='',
@phone nvarchar(30)='',
@accesscount int,
@status bit,

@ShotName varchar(500)='',
@Code varchar(50)='',
@Memo text='',
@smsNum int,
@IsPublish int,
@Theme nvarchar(50)='',
@IsPortalShow int,
@email nvarchar(200)='',
@kindesc text='',
@CopyRight text='',
@GuestOpen int,
@IsNew int,
@ptshotname varchar(100)='',
@IsVip int,
@IsVIPControl int,
@ispersonal int,
@denycreateclass int,
@classtheme nvarchar(50)='',
@kinlevel nvarchar(20)='',
@kinimgpath nvarchar(50)='',
@keyword nvarchar(100)=''
AS
BEGIN
	BEGIN TRANSACTION

    UPDATE site
    SET name=@name,description=@description,address=@address,sitedns=@sitedns,provice=@provice,city=@city,
	contractname=@contractname,QQ=@QQ,phone=@phone,accesscount=@accesscount,status=@status,keyword=@keyword
    WHERE siteid=@siteid

	UPDATE site_config
	SET ShortName=@ShotName,Code=@Code,
	Memo=@Memo,smsNum=@smsNum,IsPublish=@IsPublish,
	Theme=@Theme,IsPortalShow=@IsPortalShow,
	kindesc=@kindesc,CopyRight=@CopyRight,GuestOpen=@GuestOpen,IsNew=@IsNew,ptshotname=@ptshotname,IsVip=@IsVip,
	IsVIPControl=@IsVIPControl,ispersonal=@ispersonal,denycreateclass=@denycreateclass,classtheme=@classtheme,
	kinlevel=@kinlevel,kinimgpath=@kinimgpath
	WHERE [siteID]=@siteid

	UPDATE BasicData..kindergarten
	SET KName=@Name,Address=@Address,Privince=@provice,City=@city,telePhone=@Phone,QQ=@QQ
	WHERE [kID]=@siteid
--select * from site_config
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END
END










GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_UpdateByCMS', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_UpdateByCMS', @level2type=N'PARAMETER',@level2name=N'@email'
GO
