USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[GetReApplyStatus]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create PROCEDURE [dbo].[GetReApplyStatus]
@gbid int,
@userid int
 AS 	
declare @result int
select @result=reapply from [EBook].[dbo].[GBDownloadList]
 where userid=@userid and growthbookid=@gbid

	return @result







GO
