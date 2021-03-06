USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteList]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-7-28
-- Description:	获取站点列表
-- =============================================
CREATE PROCEDURE [dbo].[SiteList] 
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
            temp_siteid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [site_id] FROM sac_site 
        
        SET ROWCOUNT @size
        SELECT site_id,site_name
        FROM 
			@temptable AS tmptable
		INNER JOIN 
			sac_site t1 ON tmptable.temp_siteid=t1.site_id
		WHERE 
			row >@ignore
    END
    ELSE
    BEGIN
        SET ROWCOUNT @size
        SELECT site_id,site_name
        FROM sac_site
    END
END
GO
