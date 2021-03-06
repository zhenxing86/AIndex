USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetList]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	获得组织列表
-- =============================================
CREATE PROCEDURE [dbo].[OrgGetList]
@org_name nvarchar(30),
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
            temp_orgid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [org_id] FROM sac_org WHERE org_name like '%'+@org_name+'%'
        
        SET ROWCOUNT @size
        SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,o_name
        FROM sac_org a left join (select org_id,org_name as o_name from sac_org) b on a.up_org_id=b.org_id,@temptable
        WHERE a.[org_id]=temp_orgid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,o_name
        FROM sac_org a left join (select org_id,org_name as o_name from sac_org) b on a.up_org_id=b.org_id
        WHERE org_name like '%'+@org_name+'%'
    END
    ELSE
    BEGIN
        SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,o_name
        FROM sac_org a left join (select org_id,org_name as o_name from sac_org) b on a.up_org_id=b.org_id
        WHERE org_name like '%'+@org_name+'%'
    END
END



GO
