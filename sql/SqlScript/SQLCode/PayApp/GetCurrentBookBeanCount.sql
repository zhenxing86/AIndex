USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentBookBeanCount]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetCurrentBookBeanCount]
@sbid nvarchar(50)
 AS 

select bean_price from sbapp..sb_book where sbid=@sbid




GO
