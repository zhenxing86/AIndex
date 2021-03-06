USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetLists]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-11-30
-- Description:	获取组织列表
-- =============================================
CREATE PROCEDURE [dbo].[OrgGetLists]
@org_name nvarchar(30),
@page int,
@size int,
@siteid int
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
            temp_orgid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT sac_org.org_id FROM sac_org 
        INNER JOIN KWebCMS..site ON sac_org.org_id=KWebCMS..site.org_id
        WHERE 
        org_name like '%'+@org_name+'%'
            AND siteid=CASE @siteid WHEN 0 THEN siteid ELSE @siteid END
        ORDER BY siteid DESC
        
        SET ROWCOUNT @size
        SELECT a.org_id,org_name,create_datetime,up_org_id,siteid
        FROM sac_org a inner join @temptable on a.[org_id]=temp_orgid
        INNER JOIN KWebCMS..site ON a.org_id=KWebCMS..site.org_id
        WHERE  row>@ignore
        ORDER BY siteid DESC

    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,siteid
        FROM sac_org a 
        INNER JOIN KWebCMS..site ON a.org_id=KWebCMS..site.org_id
        WHERE org_name like '%'+@org_name+'%'
        AND siteid=CASE @siteid WHEN 0 THEN siteid ELSE @siteid END
        ORDER BY siteid DESC
    END
    ELSE
    BEGIN
        SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,siteid
        FROM sac_org a 
        INNER JOIN KWebCMS..site ON a.org_id=KWebCMS..site.org_id
        WHERE org_name like '%'+@org_name+'%'
        AND siteid=CASE @siteid WHEN 0 THEN siteid ELSE @siteid END
        ORDER BY siteid DESC
    END
END
GO
