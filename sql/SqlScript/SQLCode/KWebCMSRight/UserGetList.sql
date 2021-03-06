USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserGetList]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-25
-- Description:	获得管理员列表
-- =============================================
CREATE PROCEDURE [dbo].[UserGetList]
@orgid int,
@account nvarchar(30),
@username nvarchar(30),
@page int,
@size int
AS
BEGIN	  
	IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_userid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [user_id] FROM sac_user 
        WHERE sac_user.org_id=CASE @orgid WHEN -1 THEN sac_user.org_id ELSE @orgid END
    AND    account like '%'+@account+'%' and username like '%'+@username+'%'
        
        SET ROWCOUNT @size
        SELECT [user_id],account,password,username,createdatetime,
               sac_user.org_id,org_name,status
        FROM sac_user,@temptable,sac_org
        WHERE [user_id]=temp_userid AND row>@ignore AND sac_user.org_id=sac_org.org_id
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [user_id],account,password,username,createdatetime,
               sac_user.org_id,org_name,status
        FROM sac_user
        INNER JOIN sac_org ON sac_user.org_id=sac_org.org_id
		WHERE
     sac_user.org_id=CASE @orgid WHEN -1 THEN sac_user.org_id ELSE @orgid END 
    AND account like '%'+@account+'%' and username like '%'+@username+'%'
    END
    ELSE
    BEGIN
        SELECT [user_id],account,password,username,createdatetime,
               sac_user.org_id,org_name,status
        FROM sac_user
        INNER JOIN sac_org ON sac_user.org_id=sac_org.org_id
		WHERE 
     sac_user.org_id=CASE @orgid WHEN -1 THEN sac_user.org_id ELSE @orgid END
  AND  account like '%'+@account+'%' and username like '%'+@username+'%'
    END
END
GO
