USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightGetList]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightGetList]
@site_id int,
@site_instance_id int,
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
            temp_rightid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [right_id] FROM sac_site_right
        WHERE 
        site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
        AND site_instance_id=CASE @site_instance_id WHEN 0 THEN site_instance_id ELSE @site_instance_id END
        
        SET ROWCOUNT @size
        SELECT right_id,a.site_id,a.site_instance_id,right_name,right_code,site_instance_name,site_name
        FROM sac_site_right a 
        left join sac_site_instance b on a.site_instance_id=b.site_instance_id
        left join sac_site c on a.site_id=c.site_id ,@temptable
        WHERE a.[right_id]=temp_rightid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT right_id,a.site_id,a.site_instance_id,right_name,right_code,site_instance_name,site_name
        FROM sac_site_right a 
        left join sac_site_instance b on a.site_instance_id=b.site_instance_id 
        left join sac_site c on a.site_id=c.site_id 
        WHERE
        a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
        AND a.site_instance_id=CASE @site_instance_id WHEN 0 THEN a.site_instance_id ELSE @site_instance_id END
    END
    ELSE
    BEGIN
        SELECT right_id,a.site_id,a.site_instance_id,right_name,right_code,site_instance_name,site_name
        FROM sac_site_right a 
        left join sac_site_instance b on a.site_instance_id=b.site_instance_id 
        left join sac_site c on a.site_id=c.site_id 
        WHERE
        a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
        AND a.site_instance_id=CASE @site_instance_id WHEN 0 THEN a.site_instance_id ELSE @site_instance_id END
    END
END
GO
