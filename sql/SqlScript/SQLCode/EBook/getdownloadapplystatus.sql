USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getdownloadapplystatus]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[getdownloadapplystatus]
@gbid int,
@userid int
 AS 	
declare @result int
select @result=status from [EBook].[dbo].[GBDownloadList]
 where userid=@userid and growthbookid=@gbid

	return @result






GO
