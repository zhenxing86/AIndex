USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getdownloadurl]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[getdownloadurl]
@gbid int,
@userid int
 AS 	

declare @id int

select top 1 @id=id from [EBook].[dbo].[GBDownloadList]
 where userid=@userid and growthbookid=@gbid and status=2
order by gendate desc

	update [EBook].[dbo].[GBDownloadList] set downloaddate=getdate(),isdownload=1 where id=@id

select downloadpath from [EBook].[dbo].[GBDownloadList]
 where id=@id
	







GO
