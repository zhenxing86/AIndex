USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserGetCount]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserGetCount] 
@orgid int,
@account nvarchar(30),
@username nvarchar(30)
AS
    DECLARE @count int
IF @orgid>0
BEGIN
    SELECT @count=count(*) 
    FROM sac_user 
    where
     org_id=@orgid AND
     account like '%'+@account+'%' and 
     username like '%'+@username+'%'
    RETURN @count
END
ELSE
  BEGIN
    SELECT @count=count(*) 
    FROM sac_user 
    where
     account like '%'+@account+'%' and 
     username like '%'+@username+'%'
    RETURN @count
  END
GO
