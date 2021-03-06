USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_kmp_graduatemessage_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- alter date: 2009-03-06
-- Description:	获取毕业留言总数
-- =============================================
CREATE PROCEDURE [dbo].[kweb_kmp_graduatemessage_GetCount]
@siteid int,
@categorytype int,
@parentid int
AS
BEGIN 
DECLARE @count int 
    if(@siteid<>216)
     BEGIN
	
	SELECT @count=count(*) FROM kmp..GraduateMessage
	WHERE Kid=@siteid AND ((categorytype=0 OR categorytype IS NULL or categorytype=1) AND Status>0) and ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)
	RETURN @count
    END
    ELSE 
	BEGIN
    SELECT @count=count(*) FROM kmp..GraduateMessage
	WHERE Kid=@siteid AND (categorytype=@categorytype AND Status>0) and ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)
	RETURN @count
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_kmp_graduatemessage_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
