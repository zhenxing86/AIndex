USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceGetList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-14
-- Description:	获得站点实例列表
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceGetList]
@org_id int,
@site_id int,
@site_instance_name nvarchar(50),
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
            temp_siteinstanceid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [site_instance_id] FROM sac_site_instance
        WHERE 
        org_id=CASE @org_id WHEN 0 THEN org_id ELSE @org_id END
        AND site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
        AND site_instance_name LIKE '%'+@site_instance_name+'%'
        
        SET ROWCOUNT @size
        SELECT [site_instance_id],a.org_id,a.site_id,site_instance_name,org_name,site_name,personalized
        FROM sac_site_instance a 
        left join sac_org b on a.org_id=b.org_id 
        left join sac_site c on a.site_id=c.site_id ,@temptable
        WHERE a.[site_instance_id]=temp_siteinstanceid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [site_instance_id],a.org_id,a.site_id,site_instance_name,org_name,site_name,personalized
        FROM sac_site_instance a 
        left join sac_org b on a.org_id=b.org_id 
        left join sac_site c on a.site_id=c.site_id 
        WHERE
        a.org_id=CASE @org_id WHEN 0 THEN a.org_id ELSE @org_id END
        AND a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
        AND site_instance_name LIKE '%'+@site_instance_name+'%'
    END
    ELSE
    BEGIN
        SELECT [site_instance_id],a.org_id,a.site_id,site_instance_name,org_name,site_name,personalized
        FROM sac_site_instance a 
        left join sac_org b on a.org_id=b.org_id 
        left join sac_site c on a.site_id=c.site_id
        WHERE
        a.org_id=CASE @org_id WHEN 0 THEN a.org_id ELSE @org_id END
        AND a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
        AND site_instance_name LIKE '%'+@site_instance_name+'%'
    END
END
GO
