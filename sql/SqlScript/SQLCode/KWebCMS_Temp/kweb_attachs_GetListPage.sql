USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_attachs_GetListPage]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- 
--EXEC KWebCMS_Temp..[kweb_attachs_GetListPage] 'BJYY',611,0,0
-- =============================================
CREATE PROCEDURE [dbo].[kweb_attachs_GetListPage]
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN


	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)
	
	IF (@categorycode='BJYY')
	BEGIN
		IF(@page>1)
		BEGIN
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) 
			SELECT t1.contentattachsid FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE t2.categorycode=@categorycode			
			and t1.siteid=@siteid
            ORDER BY t1.isdefault DESC

			SET ROWCOUNT @size
			SELECT c.* FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid 
			WHERE row > @ignore  and siteid=@siteid
			ORDER BY isdefault DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE t2.categorycode=@categorycode			
			and t1.siteid=@siteid
			ORDER BY isdefault DESC
		END
		ELSE IF(@page=0)
		BEGIN
            declare @isdefault bit 
            set @isdefault=0
            select @isdefault=t1.isdefault from cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid
			where t2.categorycode=@categorycode and t1.siteid=@siteid  and t1.isdefault=1   
       
            IF (@isdefault=1) 
            BEGIN
			SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE t2.categorycode=@categorycode
			and t1.siteid=@siteid and isdefault=1
			ORDER BY t1.isdefault DESC
            END
            ELSE IF (@isdefault=0)
            BEGIN
            SELECT TOP(1) t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE t2.categorycode=@categorycode
			and t1.siteid=@siteid				
			ORDER BY  t1.contentattachsid DESC   
            END
		END
	END
	ELSE
	BEGIN
		IF(@page>1)
		BEGIN
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) 
			SELECT contentattachsid FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE  t2.categorycode=@categorycode
			and t1.siteid=@siteid				
			ORDER BY   t1.contentattachsid DESC

			SET ROWCOUNT @size
			SELECT c.* FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid 
			WHERE row > @ignore  and siteid=@siteid
			ORDER BY contentattachsid DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT * FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE  t2.categorycode=@categorycode
			and t1.siteid=@siteid				
			ORDER BY   t1.contentattachsid DESC
		END
		ELSE IF(@page=0)
		BEGIN
			SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid			
			 WHERE t2.categorycode=@categorycode
			and t1.siteid=@siteid				
			ORDER BY   t1.contentattachsid DESC

		END
	END
  
END




GO
