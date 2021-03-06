USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListPage_13336]    Script Date: 05/14/2013 14:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-04
-- Description:	分页读取文章数据
--[kweb_content_GetListPage_13336] 'gg',13336,1,20
-- =============================================
CREATE PROCEDURE [dbo].[kweb_content_GetListPage_13336]
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN	

DECLARE @prep int,@ignore int
DECLARE @tmptable TABLE
			(
				row int IDENTITY (1, 1),
				tmptableid bigint
			)
	if(@categorycode='yebj' and @siteid=13336)
	begin
		IF(@page>1)
		BEGIN			
			SET @prep = @size * @page
			SET @ignore=@prep - @size						
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE 
			t2.categorycode='yebj'
			AND t1.[status]=1 and t3.status=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)		
		  ORDER BY t1.orderno DESC, t1.[createdatetime] DESC		
			SET ROWCOUNT @size
			SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime] 
			FROM cms_content c join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore 			
			ORDER BY orderno DESC, c.[createdatetime] DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='yebj'
			AND t1.[status]=1	 and t3.status=0	
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)	
			ORDER BY t1.orderno DESC ,t1.[createdatetime] DESC		
		END
		ELSE IF(@page=0) 
		BEGIN
		  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='yebj'
			AND t1.[status]=1
			and t3.status=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)		
			ORDER BY t1.orderno DESC,t1.[createdatetime] DESC	    
		END		
	end
    else if(@categorycode='xw' and @siteid=13336)
	begin
		IF(@page>1)
		BEGIN			
			SET @prep = @size * @page
			SET @ignore=@prep - @size		
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid
			WHERE 
			t2.categorycode='xw'
			AND t1.[status]=1  AND t3.[status]=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)
		    
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
		  ORDER BY t1.orderno DESC, t1.[createdatetime] DESC
		

			SET ROWCOUNT @size
			SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime] 
			FROM cms_content c join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore 
			--ORDER BY orderno DESC,contentid DESC
			ORDER BY orderno DESC, c.[createdatetime] DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid
			WHERE t2.categorycode='xw'
			AND t1.[status]=1	 and t3.status=0	
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)	
			ORDER BY t1.orderno DESC ,t1.[createdatetime] DESC
		
		END
		ELSE IF(@page=0) 
		BEGIN
		  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='xw'
			AND t1.[status]=1 AND t3.[status]=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
			ORDER BY t1.orderno DESC,t1.[createdatetime] DESC	    
		END		
	end	
	else if(@categorycode='gg' and (@siteid=13364 or @siteid=13362))
	begin
		IF(@page>1)
		BEGIN
			
			SET @prep = @size * @page
			SET @ignore=@prep - @size						
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE 
			t2.categorycode='gg'
			AND t1.[status]=1 AND t3.[status]=0
			AND (t1.siteid=@siteid or t1.siteid=13336)
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
		  ORDER BY t1.orderno DESC, t1.[createdatetime] DESC
		

			SET ROWCOUNT @size
			SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime] 
			FROM cms_content c join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore 
			--ORDER BY orderno DESC,contentid DESC
			ORDER BY orderno DESC, c.[createdatetime] DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='gg'
			AND t1.[status]=1	and t3.status=0	
			AND (t1.siteid=@siteid or t1.siteid=13336)	
			ORDER BY t1.orderno DESC ,t1.[createdatetime] DESC
		
		END
		ELSE IF(@page=0) 
		BEGIN
		  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='gg'
			AND t1.[status]=1 and t3.status=0
			AND (t1.siteid=@siteid or t1.siteid=13336)
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
			ORDER BY t1.orderno DESC,t1.[createdatetime] DESC	    
		END		
	end	
    else if(@categorycode='gg' and @siteid=13336)
	begin
		IF(@page>1)
		BEGIN
			
			SET @prep = @size * @page
			SET @ignore=@prep - @size						
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE 
			t2.categorycode='gg'
			AND t1.[status]=1 AND t3.[status]=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
		  ORDER BY t1.orderno DESC, t1.[createdatetime] DESC
		

			SET ROWCOUNT @size
			SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime] 
			FROM cms_content c join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore 
			--ORDER BY orderno DESC,contentid DESC
			ORDER BY orderno DESC, c.[createdatetime] DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='gg'
			AND t1.[status]=1	and t3.status=0	
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)	
			ORDER BY t1.orderno DESC ,t1.[createdatetime] DESC
		
		END
		ELSE IF(@page=0) 
		BEGIN
		  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE t2.categorycode='gg'
			AND t1.[status]=1 and t3.status=0
			AND (t1.siteid=@siteid or t1.siteid=13364 or t1.siteid=13362)
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
			ORDER BY t1.orderno DESC,t1.[createdatetime] DESC	    
		END		
	end
	else
	begin


		IF(@page>1)
		BEGIN
			
			SET @prep = @size * @page
			SET @ignore=@prep - @size

			
			
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			 SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE --(t2.siteid=12511 or t2.siteid=0)
			 t2.categorycode=@categorycode
			AND t1.[status]=1
			AND t1.siteid=@siteid AND t3.[status]=0
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
		  ORDER BY t1.orderno DESC, t1.[createdatetime] DESC
		

			SET ROWCOUNT @size
			SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime] 
			FROM cms_content c inner join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore 
			--ORDER BY orderno DESC,contentid DESC
			ORDER BY orderno DESC, c.[createdatetime] DESC
		END
		ELSE IF(@page=1)
		BEGIN
			SET ROWCOUNT @size
			SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid
			WHERE --(t2.siteid=@siteid or t2.siteid=0)
			--AND 
			t2.categorycode=@categorycode
			AND t1.[status]=1		
			AND t1.siteid=@siteid  AND t3.[status]=0	
		    
			--ORDER BY t1.orderno DESC,t1.contentid DESC
			ORDER BY t1.orderno DESC ,t1.[createdatetime] DESC
		
		END
		ELSE IF(@page=0) 
		BEGIN
		  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
			INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
			LEFT JOIN  cms_content_draft t3 ON t1.contentid=t3.contentid 
			WHERE 
			--(t2.siteid=@siteid or t2.siteid=0) AND
			 t2.categorycode=@categorycode
			AND t1.[status]=1
			AND t1.siteid=@siteid AND t3.[status]=0
			
		   -- ORDER BY t1.orderno DESC,t1.contentid DESC
			ORDER BY t1.orderno DESC,t1.[createdatetime] DESC
	    
		END
	end
END
GO
