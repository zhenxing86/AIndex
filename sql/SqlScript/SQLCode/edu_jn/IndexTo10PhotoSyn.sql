USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[IndexTo10PhotoSyn]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      
-- Create date: 
-- Description:	
-- Memo:			
*/  
CREATE PROCEDURE [dbo].[IndexTo10PhotoSyn]
 AS 
BEGIN
	SET NOCOUNT ON
	SELECT ID, Level, ID Superior 
	INTO #CET
	FROM area WHERE ID IN(724,721,729)
	UNION ALL
	SELECT ID, Level, Superior FROM area WHERE Superior IN(724,721,729)

	SELECT 724 AS ID
	INTO #CET1
	UNION ALL
	SELECT 721
	UNION ALL
	SELECT 729

	truncate table [IndexTop10Photos]
	INSERT INTO [dbo].[IndexTop10Photos]
						 ([albumid]
						 ,[title]
						 ,[coverphoto]
						 ,[coverphotodatetime]
						 ,[net]
						 ,[kname],areaid)     
	SELECT p.* 
		FROM #CET1 c1 
			CROSS APPLY 
			(
				select top(10) CA.albumid,ca.title, ca.coverphoto, ca.coverphotodatetime, 
						ca.net, g.kname, c.Superior areaid 	
				from gartenlist g
					inner join ClassApp..class_album ca 
						on g.kid = ca.kid 
						and [status] = 1  
						and ca.coverphoto is not null
					left join dbo.PhotoState t3 
						on t3.contentid = CA.albumid
					inner join #CET c 
						on c.ID = g.areaid
				where t3.ishow is null 
					and c1.id = c.Superior 
				ORDER BY c.Level,ca.lastuploadtime desc
			)p
		
END
GO
